# ETD Vault Deployment Steps

Populate the following customer config `repo-root/config/customer-config.yaml`

## Customer Config Example:

```
customerConfig:
  - customerName: support0001
    sftpgo:
      enabled: false
    rookStorage:
      enabled: true
    etdApp:
      enabled: true
      sid: st2
      baseDomain: example.sapns2.us
      hanaInstanceNum: "00"
      logcollectorOutbound:
        enabled: true
        odataS4: []
        odataC4C: []
        btp: []
        db: [] 
```

### Adding HANA DB to logcollectorOutbound

```
customerConfig:
  - customerName: support0001
    sftpgo:
      enabled: false
    rookStorage:
      enabled: true
    etdApp:
      enabled: true
      sid: st2
      baseDomain: example.sapns2.us
      hanaInstanceNum: "00"
      logcollectorOutbound:
        enabled: true
        odataS4: []
        odataC4C: []
        btp: []
        db:
          # Example of adding ETD HANA DB to Logcollector as datasource. All certificates need to be created prior to adding the DB.
          - hostname: etd-he2.example.sapns2.us
            port: 30041
            username: ETD_AUDITOR_VIEW
            sid: HE2
            selectstatement: SELECT LOG_DATA, LOG_DATE FROM SAP_SEC_MON.\"sap.secmon.db.streaming::AuditLogView\"
            createdns: false
          # Example of adding HANA DB to Logcollector as datasource. All certificates and audit policy/log table need to be created prior to adding the DB.
          - hostname: etd-hp4.example.sapns2.us
            port: 30015
            username: SAPHANADB
            sid: HP4
            selectstatement: SELECT LOG_DATA, LOG_DATE FROM SAPHANADB.AUDIT_LOG_VIEW_ETD
            createdns: true
```