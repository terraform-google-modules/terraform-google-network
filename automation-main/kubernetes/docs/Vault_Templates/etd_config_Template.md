### config
#### Required Values:
- **BASE_DOMAIN**
- **CS_PASS**
- **ETD_SID**
- **HANA_HOSTNAME**
- **HANA_INSTANCE_NUM**
- **HANA_IP**
- **HP4_IP**
- **HP4_PASS**
- **HW_PASS**
- **LC_PASS**
- **LL_PASS**
- **NM_PASS**
- **HANA_P12**
- **HANA_P12_PASS**
- **LC_OB_P12**
- **LC_OB_PASS**
- **LC_P12**
- **LC_P12_PASS**

#### Optional Values:

---

### Example Table with required and optional values:

| Key                | Value                                                                                       |
|--------------------|---------------------------------------------------------------------------------------------|
| BASE_DOMAIN        | support0012.ste.dev.scs.sap                                                                  |
| CS_PASS            | QwerRewq123                                                                                 |
| ETD_SID            | st2                                                                                          |
| HANA_HOSTNAME      | etd-he2.support0012.ste.dev.scs.sap                                                          |
| HANA_INSTANCE_NUM  | 00                                                                                           |
| HANA_IP            | 10.104.8.9                                                                                  |
| HP4_IP             | 10.104.0.58                                                                                 |
| HP4_PASS           | QwerRewq123                                                                                 |
| HW_PASS            | QwerRewq123                                                                                 |
| LC_PASS            | <Populate>                                                                     |
| LL_PASS            | QwerRewq123                                                                                 |
| NM_PASS            | QwerRewq123                                                                                 |
| HANA_P12           | <Populate>       |
| HANA_P12_PASS      | QwerRewq123                                                                                 |
| LC_OB_P12          | <Populate>        |
| LC_OB_PASS         | QwerRewq123                                                                                 |
| LC_P12             | <Populate>        |
| LC_P12_PASS        | QwerRewq123  


Example JSON Templated:

```json
{ "BASE_DOMAIN": "<Populate>",
  "CS_PASS": "<Populate>", 
  "ETD_SID": "<Populate>",
  "HANA_HOSTNAME": "<Populate>", "HANA_INSTANCE_NUM": "<Populate>",
  "HANA_IP": "<Populate>", 
  "HP4_IP": "<Populate>", 
  "HP4_PASS": "<Populate>", 
  "HW_PASS": "<Populate>",
  "LC_PASS": "<Populate>", 
  "LL_PASS": "<Populate>", 
  "NM_PASS": "<Populate>", 
  "HANA_P12": "<Populate>", 
  "HANA_P12_PASS": "<Populate>", 
  "LC_OB_P12": "<Populate>", 
  "LC_OB_PASS": "<Populate>", 
  "LC_P12": "<Populate>", 
  "LC_P12_PASS": "<Populate>" }
```


Example JSON Secret:

```json
{
  "BASE_DOMAIN": "support0012.ste.dev.scs.sap",
  "CS_PASS": "QwerRewq123",
  "ETD_SID": "st2",
  "HANA_HOSTNAME": "etd-he2.support0012.ste.dev.scs.sap",
  "HANA_INSTANCE_NUM": "00",
  "HANA_IP": "10.104.8.9",
  "HP4_IP": "10.104.0.58",
  "HP4_PASS": "QwerRewq123",
  "HW_PASS": "QwerRewq123",
  "LC_PASS": "a884579a0de791d1c7sssc60fe07f...",
  "LL_PASS": "QwerRewq123",
  "NM_PASS": "QwerRewq123",
  "HANA_P12": "MIIXFgIBAzCCFtwGCSqGSIb3DQEH...",
  "HANA_P12_PASS": "QwerRewq123",
  "LC_OB_P12": "MIIXFgIBAzCCFtwGCSqGSIb3DQE...",
  "LC_OB_PASS": "QwerRewq123",
  "LC_P12": "MIIXFgIBAzCCFtwGCSqGSIb3DQEHAa...",
  "LC_P12_PASS": "QwerRewq123"
}
```


