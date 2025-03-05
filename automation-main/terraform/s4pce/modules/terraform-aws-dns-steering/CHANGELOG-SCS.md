# 2024-11-12 i868402
* Changed Changelog to new format.
* Tested Version Requirements to match contributing guidelines.
* Added missing minimum version

## Version 1.0.0 (2023-06-21) (i587430)
### Initial version established with the following features
* The purpose of this module is to create intermediary CNAME records for
  * Customers to CNAME their intended DNS records (the FQDN of the certificate they provide) to
  * Ops to be able to change backing endpoints without impacting the Customer
* Creates either private or public customer-specific zone and records for all passed `endpoints`
