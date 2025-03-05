# ETD Vault Deployment Steps

Create the following required paths and their required secrets before deploying the ETD application:

## Vault Path Structure:

Terminology:

Root:

`...dev/gardener/clustername will be referred to as the root directory:`

From the following vaultBasePath: (../config/env-config.yaml)

`vaultBasePath: kv_core_secrets/data/products/ste/dev/gardener/clustername`

From the root the following folders are required:

```
`...clustername`
      `global`                #This is a folder
        -> `argocd`           #This is a secret
        -> `dockerconfig`     #This is a secret
        -> `grafana`          #This is a secret
      `customer00##` 
        -> `ecs-etd`          #This is a folder
              -> `config`     #This is a secret
              -> `hanadb`     #This is a secret
              -> `jwt_key`    #This is a secret
              -> `route53`    #This is a secret
```

### Global templates:

[argocd Template](/docs/Vault_Templates/argoCD_Template.md)

[docker Template](/docs/Vault_Templates/docker_Template.md)

[grafana Template](/docs/Vault_Templates/grafana_Template.md)

### Customer00## templates:

[config Template](/docs/Vault_Templates/etd_config_Template.md)

[hanadb Template](/docs/Vault_Templates/etd_hanadb_Template.md)

[jwt_key Template](/docs/Vault_Templates/etd_jwtkey_Template.md)

[route53 Template](/docs/Vault_Templates/etd_route53_Template.md)
