# Deployment Steps

Follow these steps to deploy your Kubernetes cluster and associated components:

### **Add global secrets to vault for argocd and pgsql**:
#### **Vault Secrets Structure**

The deployment requires specific secrets to be stored in Vault. These secrets are organized under the `global` base path and are divided into two main sections: `argocd` for Argo CD configurations and `pgsql` for PostgreSQL database configurations.

<details>
<summary><b>Global Vault Path Structure and Detail</b></summary>

#### Vault Path Structure:

```txt
global
├── argocd
│ ├── ARGOCD_ADMIN
│ ├── ARGOCD_ADMIN_PASS
│ ├── REPO_TECH_PAT
│ └── REPO_TECH_USER
└── pgsql
  ├── HOST
  ├── PASSWORD
  ├── PORT
  └── USERNAME
```

#### Vault Secret Examples

ste/dev/gardener/global/argocd:
```
{
  "ARGOCD_ADMIN": "admin",
  "ARGOCD_ADMIN_PASS": "Password",
  "REPO_TECH_PAT": "<Token>",
  "REPO_TECH_USER": "<TokenUser>"
}
```

ste/dev/gardener/global/pgsql:
```
{
  "HOST": "sftpdb.zzzzzz.us-gov-west-1.rds.amazonaws.com",
  "PASSWORD": "Password",
  "PORT": "5432",
  "USERNAME": "postgres"
}
```

ste/dev/gardener/global/aws:
```
{
  "credentials": "[default]\naws_access_key_id=XXX\naws_secret_access_key=XXX\nregion=us-gov-west-1"
}
```

ste/dev/gardener/global/vault:
```
{
  "ROLE_ID": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "SECRET_ID": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "VAULT_ADDR": "https://vault.my.vault.us"
}
```
#### Vault Password Details:
| Section | Secret Name         | Description                                | Notes                                                                                |
| ------- | ------------------- | ------------------------------------------ | ------------------------------------------------------------------------------------ |
| argocd  | `ARGOCD_ADMIN`      | User defined Argo CD admin username        | Example value: `admin`                                                               |
| argocd  | `ARGOCD_ADMIN_PASS` | User defined Argo CD admin password        | Recommended to generate random value. <br>Example command: `openssl rand -base64 16` |
| argocd  | `REPO_TECH_PAT`     | Repository technical personal access token | Generated in previous step.                                                          |
| argocd  | `REPO_TECH_USER`    | User defined Repository technical user     | Example value: `REPO_TECH_USER`                                                      |
| pgsql   | `HOST`              | PostgreSQL database host                   | Default host endpoint generated when RDS instance is created via terraform.          |
| pgsql   | `PASSWORD`          | PostgreSQL database password               | Default admin password generated when RDS instance is created via terraform.         |
| pgsql   | `PORT`              | PostgreSQL database port                   | Default port for PostgreSQL is `5432`.                                               |
| pgsql   | `USERNAME`          | PostgreSQL database username               | Default admin username generated when RDS instance is created via terraform.         |
</details>