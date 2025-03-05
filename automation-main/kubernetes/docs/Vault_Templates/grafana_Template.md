### Grafana Secret
#### Required Values:
- **admin-password**
- **admin-user**
- **oidc_api_uri**
- **oidc_auth_uri**
- **oidc_client_id**
- **oidc_client_secret**
- **oidc_token_uri**

#### Optional Values:

Example Table with required and optional values:

| Key                 | Value                                                                                       |
|---------------------|---------------------------------------------------------------------------------------------|
| admin-password      | `<Populate>`                                                                                 |
| admin-user          | `<Populate>`                                                                                 |
| oidc_api_uri        | `<Populate>`                                                                                 |
| oidc_auth_uri       | `<Populate>`                                                                                 |
| oidc_client_id      | `<Populate>`                                                                                 |
| oidc_client_secret  | `<Populate>`                                                                                 |
| oidc_token_uri      | `<Populate>`                                                                                 |

Example JSON Secret Templated:

```json
{ "admin-password": "<Populate>", "admin-user": "<Populate>", "oidc_api_uri": "<Populate>", "oidc_auth_uri": "<Populate>", "oidc_client_id": "<Populate>", "oidc_client_secret": "<Populate>", "oidc_token_uri": "<Populate>" }
```

Example JSON Secret:

```json
{
  "admin-password": "2HLU2e3?%LA7p1G",
  "admin-user": "admin",
  "oidc_api_uri": "https://ste.ias.preprod.scp.sapns2.us/oauth2/userinfo",
  "oidc_auth_uri": "https://ste.ias.preprod.scp.sapns2.us/oauth2/authorize",
  "oidc_client_id": "391c1378-4489-45dc-b53f-1e6b99bede0a",
  "oidc_client_secret": "_DECN2l.?9rTkmXd=-4rgaG7wCF_Rd=h",
  "oidc_token_uri": "https://ste.ias.preprod.scp.sapns2.us/oauth2/token"
}
