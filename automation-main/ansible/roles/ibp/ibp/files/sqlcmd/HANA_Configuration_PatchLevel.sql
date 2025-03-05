SELECT
/*

[NAME]

- HANA_Configuration_PatchLevel

[DESCRIPTION]

- Current patch level (SPS, Revision)

[SOURCE]

- SAP Note 1969700

[DETAILS AND RESTRICTIONS]


[VALID FOR]

- Revisions:              all
- Statistics server type: all

[SQL COMMAND VERSION]

- 2014/06/02:  1.0 (initial version)
- 2017/11/14:  1.1 (updated Revision formula for SAP HANA 2.0)

[INVOLVED TABLES]

- M_SYSTEM_OVERVIEW

[INPUT PARAMETERS]


[OUTPUT PARAMETERS]

- INST_ID:  Installation identifier
- INST_NO:  Installation number
- VERSION:  Full version information
- REVISION: Revision level
- SPS:      Support package stack

[EXAMPLE OUTPUT]

---------------------------------------------------------------
|INST_ID|INST_NO|VERSION                         |REVISION|SPS|
---------------------------------------------------------------
|C11    |     01|1.00.74.00.390550 (NewDB100_REL)|   74.00|  7|
---------------------------------------------------------------

*/

  INSTANCE_NAME INST_ID,
  LPAD(INSTANCE_NUMBER, 7) INST_NO,
  VERSION,
  LPAD(TO_DECIMAL(REVISION, 10, 2), 8) REVISION,
  LPAD(LPAD((CASE
    WHEN VERSION LIKE '1%' AND REVISION BETWEEN  45 AND  59 THEN 5
    WHEN VERSION LIKE '1%' AND REVISION BETWEEN  28 AND  44 THEN 4
    WHEN VERSION LIKE '1%' AND REVISION BETWEEN  20 AND  27 THEN 3
    WHEN VERSION LIKE '1%' AND REVISION BETWEEN  12 AND  19 THEN 2
    WHEN VERSION LIKE '1%' AND REVISION BETWEEN   1 AND  11 THEN 1
    ELSE FLOOR(REVISION / 10)
  END), 2, '0'), 3) SPS
FROM
( SELECT
    MAX(MAP(NAME, 'Instance ID', VALUE)) INSTANCE_NAME,
    MAX(MAP(NAME, 'Instance Number', VALUE)) INSTANCE_NUMBER,
    MAX(MAP(NAME, 'Version', VALUE)) VERSION,
    MAX(MAP(NAME, 'Version', TO_NUMBER(SUBSTR(VALUE, LOCATE(VALUE, '.', 1, 2) + 1, LOCATE(VALUE, '.', 1, 3) - LOCATE(VALUE, '.', 1, 2) - 1) ||
        MAP(LOCATE(VALUE, '.', 1, 4), 0, '', '.' || SUBSTR(VALUE, LOCATE(VALUE, '.', 1, 3) + 1, LOCATE(VALUE, '.', 1, 4) - LOCATE(VALUE, '.', 1, 3) - 1 ))))) REVISION
  FROM
    M_SYSTEM_OVERVIEW
);
