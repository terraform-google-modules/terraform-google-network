ClamAV FIPS Compatibility
=========================

To ensure that ClamAV can continue to function on a FIPS enabled RHEL 9 or Ubuntu 20.04 system the following needs to be done as a temporary workaround until an upstream pull request is accepted addressing the root issue:

1. Create a shared object that can be preloaded to enable MD5 use for ClamAV:
```
gcc -fPIC -shared -o fips_enable.so fips_enable.c -ldl -nostdlib -nodefaultlibs -static

// Usage:
// LD_PRELOAD=./fips_enable.so /path/to/clamapp
// LD_PRELOAD=/lib/fips_enable.so /usr/bin/clamscan
// LD_PRELOAD=/lib/fips_enable.so /usr/bin/freshclam
// In the Unit files, add this to the environment section:
// Environment="LD_PRELOAD=/lib/fips_enable.so"

#define _GNU_SOURCE
#include <dlfcn.h>

// Define function pointers for the intercepted function, and the target function
static const void* (*original_EVP_get_digestbyname)(const char *name);
static const void* (*dl_EVP_MD_fetch)(void *ctx, const char *alg, const char *opts);

// Our replacement function
const void* EVP_get_digestbyname(const char *name) {

    // Load the original EVP_get_digestbyname if not already loaded
    if (!original_EVP_get_digestbyname) {
        original_EVP_get_digestbyname = dlsym(RTLD_NEXT, "EVP_get_digestbyname");
    }
    if (!dl_EVP_MD_fetch) {
        dl_EVP_MD_fetch = dlsym(RTLD_DEFAULT, "EVP_MD_fetch");
    }

    // If the name is MD5, return the FIPS version
    if (name[0] == 'm' && name[1] == 'd' && name[2] == '5' && name[3] == '\0') {
        return (const void *)dl_EVP_MD_fetch( (void *)0, name, "-fips");
    }
    else {
        return (const void *)original_EVP_get_digestbyname(name);
    }
}
```

2. The contents are Base64 encoded, bzip2 compressed, and saved in `/lib/fips_enable.so`
```
cat fips_enable.so | bzip2 | base64

QlpoOTFBWSZTWQcd3uEAA5b////f19/W8//f//9zFL/n//LPKkFIIAYBQP38cEBGbsNJwAMbM3ba
0i4wNNKaE00aTTNUaek/RTQYho0BoyaaNGj1AADQBp5TRoGjaRoGQaGjRk9Q9E8oNRNNNKfpGTRq
eTEIjNQ9Ewm0jRk0NNGTQBmgRpkbSabRHpDEA0NHo1AaZNNANNEgTVNDeo1NBhMmRiPUND1DT9U0
yGjEZGRoGgBkA0A00ZqNomgaAaaYDFU1GgaAAAAAA0ADQAAAAAAAAAAAAAAA7BgqoXdT3r7oDhRC
akppApnSpuUIYM9rS+5NYS84MGYqAwKVCAj9FlLE4nAB1OhJQg8dV6alEUA52H4UHELZIV4ywcSG
FlWTBPilH501Jvs4IDGXiGaEythnyVbek69QdUeS9EIUFjuQLPdrNWf+XvlZqqQUCARyNz8mW3R1
/Ze1lGVivCTbzJDTzaABJcLBqLhsAAB9iniKAFJTrl5qQ0adCBtEQXkD5jMYiuLFDVqHGApyn1Ep
AQBEpSiCEiQgW5RN0OAiAZM0QAUiJ5AWKF+gNVEAECiRgUQQ5JqgRjEARFL25ZSvWYlK4pYz0cnu
yVzEM+ZOaSUUQEhsgWCAiCAjfbaIbSsYB4B1ipKE68j2tRaIv2WTvKKs4FwZ3g3ybgw51rALNBhH
GQLREkW18y30AGqJaIJFKuRCCAhEQMKdVFcVCRFITGcigDQDBxhKX5icovw0ZaBChbo5SuNswCiA
RHn9KnAwU7TNzeU2PERBb17LWkkXI45CsYNcvXMTjkKihign2+hoK+j5m1vVuHnjMKLJDz1yXn3x
+HeGRfzW8GKeDUGZGCVUL5PAsd7xXQTsKBiPFSCMNMVXgaA8eF5dCTC9A9JDYY2UGEQpsuOoHCAt
NO1z8nmTYT69F9kUwVB4BNDwaVSuHkNipQ7WfJtjf5FRoREWZFqADMu5izWcnJURmSJ3tbzjfR7w
J7pWU+7t1hl4CVnBODyoy7VcVjWXFPaHGijaNKfWUKMtWJuzqDRQ+zYrOGwjSGGp7M8fCRg3lPfz
Ue9dtLVWghEmarKKC9iUYQvYLkuyL0zNq1AKi0tPDK0CisJKi09PiyFjMpdE1p1dk+yKoowEYK++
cjRQl4OCS4aWgNcGCQqFG3YyuMyE10xQFxyocWCjaQaeDsKjwkpMCB9qo5QipBwgk49XQXsfNOAR
YKmHKoqgQZzrbjpWVpYOON6A66L4L+E/I+rr2HdOiaks1ZGD/arT/8OhHfEOm07Iv6riVoX8vSej
kilWe4qCsVCBBVlhRRVMewoZOWuUsKuJXsOf8XckU4UJAHHd7hA=
```

This is a temporary measure and will be removed, and it will likely break in the future as OpenSSL deprecates MD5 out of their libraries entirely.

Author Information
------------------

* Mark Carey (i745422) mark.carey@sap.com
