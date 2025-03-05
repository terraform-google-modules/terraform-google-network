### ArgoCD Secret
#### Required Values:
- **ARGOCD_ADMIN**
- **ARGOCD_ADMIN_PASS**
- **REPO_TECH_PAT**
- **REPO_TECH_USER**

#### Optional Values:
- **IAS_CLIENTID**
- **IAS_CLIENTSECRET**
- **IAS_ISSUER**

Example Table with required and optional values:

```
| Key                | Value                          |
|--------------------|--------------------------------|
| ARGOCD_ADMIN       | admin                          |
| ARGOCD_ADMIN_PASS  | <Populate>                     |
| REPO_TECH_PAT      | <Populate>            |
| REPO_TECH_USER     | REPO_TECH_USER                 |
| IAS_CLIENTID       | <Populate>                     |
| IAS_CLIENTSECRET   | <Populate>                     |
| IAS_ISSUER         | <Populate>                     |
```

Example JSON Secret Templated:
```json
{
  "ARGOCD_ADMIN": "admin",
  "ARGOCD_ADMIN_PASS": "QwerRewq123",
  "IAS_CLIENTID": "<Populate>",
  "IAS_CLIENTSECRET": "<Populate>",
  "IAS_ISSUER": "<Populate>",
  "REPO_TECH_PAT": "kVGvCnzQXZPLyLJ1qsy6",
  "REPO_TECH_USER": "REPO_TECH_USER"
}
```

Example JSON Secret:
```json
{
  "ARGOCD_ADMIN": "admin",
  "ARGOCD_ADMIN_PASS": "QwerRewq123",
  "IAS_CLIENTID": "a43b21f0-c91d-4d58-9c8e-9d1c9bc85b2d",
  "IAS_CLIENTSECRET": "YdDk1JpwR2Bd6GhW1lX5O=9s5sI4f2w3",
  "IAS_ISSUER": "https://dev.ias.example.org",
  "REPO_TECH_PAT": "kVGvCnzQXZPLyLJ1qsy6",
  "REPO_TECH_USER": "REPO_TECH_USER"
}
```