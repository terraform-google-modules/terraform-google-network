### Secret Template for HOSTNAME, INSTANCE_NUM, and IP

#### Required Values:
- **HOSTNAME**
- **INSTANCE_NUM**
- **IP**

#### Optional Values:

Example Table with required values:

| Key           | Value                                |
|---------------|--------------------------------------|
| HOSTNAME      | etd-he2.support0012.ste.dev.scs.sap  |
| INSTANCE_NUM  | 00                                   |
| IP            | 10.104.8.9                           |

Example JSON Secret Templated:

```json
{
  "HOSTNAME": "<Populate>",
  "INSTANCE_NUM": "<Populate>",
  "IP": "<Populate>"
}
```

Example JSON Secret:
```json
{
  "HOSTNAME": "etd-he2.support0012.ste.dev.scs.sap",
  "INSTANCE_NUM": "00",
  "IP": "10.104.8.9"
}
```