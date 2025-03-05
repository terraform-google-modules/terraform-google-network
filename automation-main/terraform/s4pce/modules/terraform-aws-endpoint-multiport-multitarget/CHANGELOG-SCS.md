# 2024-12-02 i868402
* Removes unused null-context changelog dependency

# 2024-11-12 i868402
* Changed Changelog to new format.
* Tested Version Requirements to match contributing guidelines.
* Add/Refactor example-root for module.
* Add missing minimum version

## Version 1.0.5 (2023-06-14) (c5309336)
### Enhancement - Null Context Update
* Updated `terraform-null-context` to use `terraform-null-context/modules/legacy`

## Version 1.0.4 (2022-11-30) (c5337390)
### Enhancement - add arn_suffix to output
* add arn_suffix to output so that it can be used for cloudwatch alarms

## Version 1.0.3 (2022-09-22) (c5337390)
### Enhancement - add health check port
* Add the ability to do health checks against a different port than the listening port

## Version 1.0.2 (2022-08-30) (c5337390)
### Enhancement - Add az and arn outputs
* Add availability_zones and arn as endpoint_service outputs

## Version 1.0.1 (2022-08-12) (c5337390)
### Enhancement - Add enable_cross_zone_load_balancing option
* Add nlb_enable_cross_zone_load_balancing as an option with default to true


## Version 1.0.0 (i868402)
### Initial version established with the following features
* Creates Network Load Balancer and connects to instance
* Creates TargetGroups and Listeners based on port list
* Creates Endpoint Service from the Network Load Balancer
* Creates Endpoint that consumes the Endpoint Service.
* Allows multiple targets assigned to single target group
