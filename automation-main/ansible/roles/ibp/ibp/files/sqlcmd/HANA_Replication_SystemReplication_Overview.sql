SELECT
/*

[NAME]

- HANA_Replication_SystemReplication_Status

[DESCRIPTION]

- Status of system replication of individual services

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]


[VALID FOR]

- Revisions:              all
- Statistics server type: all

[SQL COMMAND VERSION]

- 2015/02/24:  1.0 (initial version)
- 2015/03/17:  1.1 (SECONDARY_ACTIVE_STATUS included)
- 2015/07/21:  1.2 (ASYNC_BUFF_USED_MB included)
- 2020/02/19:  1.3 (M_SYSTEM_REPLICATION and OPERATION_MODE included)

[INVOLVED TABLES]

- M_SERVICE_REPLICATION
- M_SYSTEM_REPLICATION

[INPUT PARAMETERS]

- HOST

  Host name

  'saphana01'     --> Specic host saphana01
  'saphana%'      --> All hosts starting with saphana
  '%'             --> All hosts

- PORT

  Port number

  '30007'         --> Port 30007
  '%03'           --> All ports ending with '03'
  '%'             --> No restriction to ports

- REPLICATION_STATUS

  Status of replication (e.g. ACTIVE, ERROR)

  'ERROR'         --> Replication status ERROR
  '%'             --> No restriction related to replication status

- REPLICATION_STATUS_DETAILS

  Details of replication status

  'Log shipping timeout occurred' --> Only entries related to log shipping timeout
  '%'                             --> No restriction related to replication status details

[OUTPUT PARAMETERS]

- PATH:               Replication path (source site -> target site)
- PORT:               Port
- REPLICATION_MODE:   Replication mode
- OPERATION_MODE:     Operation mode
- SHIP_DELAY_H:       Log shipping delay (h)
- ASYNC_BUFF_USED_MB: Current filling level of asynchronous log shipping buffer (MB)
- STATUS:             System replication status
- STATUS_DETAILS:     Details of system replication status
- SEC_ACTIVE:         Active status of secondary system ('YES' if active)
- HOSTS:              Host names (source host -> target host)

[EXAMPLE OUTPUT]

-------------------------------------------------------------------------------------------------------
|PATH      |HOSTS                     |PORT |SHIP_DELAY_H|MODE   |STATUS|STATUS_DETAILS               |
-------------------------------------------------------------------------------------------------------
|ha1 -> ha2|saphana2100 -> saphana2101|30205|       27.46|SYNCMEM|ERROR |Log shipping timeout occurred|
-------------------------------------------------------------------------------------------------------

*/

  R.SITE_NAME || ' -> ' || R.SECONDARY_SITE_NAME PATH,
  LPAD(TO_VARCHAR(R.PORT), 5) PORT,
  R.REPLICATION_MODE,
  SR.OPERATION_MODE,
  LPAD(TO_DECIMAL(SECONDS_BETWEEN(R.SHIPPED_LOG_POSITION_TIME, R.LAST_LOG_POSITION_TIME) / 3600, 10, 2), 12) SHIP_DELAY_H,
  LPAD(TO_DECIMAL((R.LAST_LOG_POSITION - R.SHIPPED_LOG_POSITION) * 64 / 1024 / 1024, 10, 2), 18) ASYNC_BUFF_USED_MB,
  R.REPLICATION_STATUS STATUS,
  R.REPLICATION_STATUS_DETAILS STATUS_DETAILS,
  R.SECONDARY_ACTIVE_STATUS SEC_ACTIVE,
  R.HOST || ' -> ' || R.SECONDARY_HOST HOSTS
FROM
( SELECT                  /* Modification section */
    '%' HOST,
    '%' PORT,
    '%' REPLICATION_STATUS,
    '%' REPLICATION_STATUS_DETAILS,
    -1 MIN_LOG_SHIPPING_DELAY_S
  FROM
    DUMMY
) BI,
  M_SERVICE_REPLICATION R,
  M_SYSTEM_REPLICATION SR
WHERE
  R.HOST LIKE BI.HOST AND
  TO_VARCHAR(R.PORT) LIKE BI.PORT AND
  R.REPLICATION_STATUS LIKE BI.REPLICATION_STATUS AND
  UPPER(R.REPLICATION_STATUS_DETAILS) LIKE UPPER(BI.REPLICATION_STATUS_DETAILS) AND
  ( BI.MIN_LOG_SHIPPING_DELAY_S = -1 OR
    SECONDS_BETWEEN(R.SHIPPED_LOG_POSITION_TIME, R.LAST_LOG_POSITION_TIME) >= BI.MIN_LOG_SHIPPING_DELAY_S
  ) AND
  R.SITE_ID = SR.SITE_ID AND
  R.SECONDARY_SITE_ID = SR.SECONDARY_SITE_ID
ORDER BY
  1, 2, 3
