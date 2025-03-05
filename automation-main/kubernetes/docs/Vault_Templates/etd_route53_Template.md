### Secret Template for route53

#### Required Values:
- **AWS_ACCESS_KEY_ID**
- **AWS_REGION**
- **AWS_SECRET_ACCESS_KEY**
- **BASE_DOMAIN**
- **ZONEID**

#### Optional Values:
- None

Example Table with required values:

| Key                     | Value                                 |
|-------------------------|---------------------------------------|
| AWS_ACCESS_KEY_ID       | AKIAZ3SNCVBUWUOGJNGO                  |
| AWS_REGION              | us-gov-west-1                         |
| AWS_SECRET_ACCESS_KEY  | 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 |
| BASE_DOMAIN             | support0012.ste.dev.scs.sap           |
| ZONEID                  | Z05510801AH8Y7KLC6Z2H                |

Example JSON Secret Templated:

```json
{
  "AWS_ACCESS_KEY_ID": "<Populate>",
  "AWS_REGION": "<Populate>",
  "AWS_SECRET_ACCESS_KEY": "<Populate>",
  "BASE_DOMAIN": "<Populate>",
  "ZONEID": "<Populate>"
}
```

Example JSON Secret:

```json
{
  "AWS_ACCESS_KEY_ID": "AKIAZ3SNCVBUWUOGJNGO",
  "AWS_REGION": "us-gov-west-1",
  "AWS_SECRET_ACCESS_KEY": "TWXmgRDQB/av8Fdx1/ZTkBu2o3dYtEkLsvRaYN+f",
  "BASE_DOMAIN": "support0012.ste.dev.scs.sap",
  "ZONEID": "Z05510801AH8Y7KLC6Z2H"
}
```





