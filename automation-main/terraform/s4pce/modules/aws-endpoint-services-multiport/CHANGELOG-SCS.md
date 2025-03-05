# 2024-11-12 i868402
* Changed Changelog to new format.
* Tested Version Requirements to match contributing guidelines.
* Split Example Root Validation into layers as original had a circular dependency

## Version 0.13-000007 (2023-09-20) (i587430)
### Enhancement - multiple NLB targets support
* Added new variable `nlb_target_ids` (list of `nlb_target_id`, otherwise same behavior), handle either `nlb_target_id` or `nlb_target_ids` being set, and attach all `target_id`/port combinations as `aws_lb_target_group_attachment` resources (instead of a single `nlb_target_id` and the range of `nlb_port_list`)


## Version 0.13-000006 (2023-06-14) (c5309336)
### Enhancement - Null Context Update
* Updated `terraform-null-context` to use `terraform-null-context/modules/legacy`

## Version 0.13-000005 (2021-09-29) (c5329049)
### Enhancement - Resolve AWS VPC Endpoint
* updated the module so that endpoint acceptance is no longer required
* Modified the endpoint services modules to allow principals
* Removed module dependency related code

## Version 0.13-000004 (2021-09-03) (c5329049)
### Enhancement - Added cross-zone functionality to load balancer
* Added cross-zone functionality to load balancer

## Version 0.13-000003 (2021-06-16) (i868402)
### Enhancement - Update allowing static IP sources
* updated to allow static ip
* defaults to instance id
* updated example root

## Version 0.13-000002 (2021-05-10) (c5309377)
### Bugfix - Update required_providers for terraform
* update versions.tf to the format required by Terraform 0.13 (and later)

## Version 0.13-000001 (2021-02-23) (i868402)
### Initial version established with the following features
* Creates Network Load Balancer and connects to instance
* Creates TargetGroups and Listeners based on port list
* Creates Endpoint Service from the Network Load Balancer
* Creates Endpoint that consumes the Endpoint Service.
