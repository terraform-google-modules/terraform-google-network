### Docker Secret
#### Required Values:
- **dockerconfig**
- **password**
- **username**

#### Optional Values:

Example Table with required and optional values:

| Key             | Value                                                                                       |
|-----------------|---------------------------------------------------------------------------------------------|
| dockerconfig    | `<Populate>`                                                                                 |
| password        | `<Populate>`                                                                                 |
| username        | `<Populate>`                                                                                 |


Example JSON Secret Templated:

```json
{
  "dockerconfig": "<Populate>",
  "password": "<Populate>",
  "username": "<Populate>"
}
```

Example JSON Secret:

```json
{
  "dockerconfig": "{\n   \"auths\": {\n      \"https://example.harbor.com/\": {\n         \"auth\": \"bXVsdGltY2FkY2x1c3Rlci11c2VyOmZkZmdwVm5Tb2w9NzdXW0wzqqlJwZUtFmkFQzFwM2M9Vx0a0k25XsOlf2JgQ==\"\n      }\n   }\n}\n",
  "password": "zGhqPb3vMn9HkF1s8DhXh4TtrT9osYwp4",
  "username": "user$cluster-dev"
}
```
