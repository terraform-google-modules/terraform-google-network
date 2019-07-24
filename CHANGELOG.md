# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][keepachangelog-site],
and this project adheres to [Semantic Versioning][semver-site].

## [Unreleased]

## [1.1.0] - 2019-07-24

### Added

- `auto_create_subnetworks` variable and `description` variable. [#57]

## [1.0.0] - 2019-07-12

### Changed

- Supported version of Terraform is 0.12. [#47]

## [0.8.0] - 2019-06-12

### Added

- A submodule to configure Shared VPC network attachments. [#45]

## [0.7.0] - 2019-05-27

### Added

- New firewall submodule [#40]

### Fixed

- Shared VPC service account roles are included in the README. [#32]
- Shared VPC host project explicitly depends on the network to avoid a
  race condition. [#36]
- gcloud dependency is included in the README. [#38]

## [0.6.0] - 2019-02-21

### Added

- Add ability to delete default gateway route [#29]

## [0.5.0] - 2019-01-31

### Changed

- Make `routing_mode` a configurable variable. Defaults to "GLOBAL" [#26]

### Added

- Subnet self links as outputs. [#27]
- Support for route creation [#14]
- Add example for VPC with many secondary ranges [#23]
- Add example for VPC with regional routing mode [#26]

### Fixed

- Resolved issue with networks that have no secondary networks [#19]

## [0.4.0] - 2018-09-25

### Changed

- Make `subnet_private_access` and `subnet_flow_logs` into strings to be consistent with `shared_vpc` flag [#13]

## [0.3.0] - 2018-09-11

### Changed

- Make `subnet_private_access` default to false [#6]

### Added

- Add support for controlling subnet flow logs [#6]

## [0.2.0] - 2018-08-16

### Added

- Add support for Shared VPC hosting

## [0.1.0] - 2018-08-08

### Added

- Initial release
- A Google Virtual Private Network (VPC)
- Subnets within the VPC
- Secondary ranges for the subnets (if applicable)

[Unreleased]: https://github.com/terraform-google-modules/terraform-google-network/compare/v1.1.0...HEAD
[1.1.0]: https://github.com/terraform-google-modules/terraform-google-network/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/terraform-google-modules/terraform-google-network/compare/v0.8.0...v1.0.0
[0.8.0]: https://github.com/terraform-google-modules/terraform-google-network/compare/v0.7.0...v0.8.0
[0.7.0]: https://github.com/terraform-google-modules/terraform-google-network/compare/v0.6.0...v0.7.0
[0.6.0]: https://github.com/terraform-google-modules/terraform-google-network/compare/v0.5.0...v0.6.0
[0.5.0]: https://github.com/terraform-google-modules/terraform-google-network/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/terraform-google-modules/terraform-google-network/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/terraform-google-modules/terraform-google-network/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/terraform-google-modules/terraform-google-network/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/terraform-google-modules/terraform-google-network/releases/tag/v0.1.0
[#57]: https://github.com/terraform-google-modules/terraform-google-network/pull/57
[#47]: https://github.com/terraform-google-modules/terraform-google-network/pull/47
[#45]: https://github.com/terraform-google-modules/terraform-google-network/pull/45
[#40]: https://github.com/terraform-google-modules/terraform-google-network/pull/40
[#38]: https://github.com/terraform-google-modules/terraform-google-network/pull/38
[#36]: https://github.com/terraform-google-modules/terraform-google-network/pull/36
[#32]: https://github.com/terraform-google-modules/terraform-google-network/pull/32
[#29]: https://github.com/terraform-google-modules/terraform-google-network/pull/29
[#27]: https://github.com/terraform-google-modules/terraform-google-network/pull/27
[#26]: https://github.com/terraform-google-modules/terraform-google-network/pull/26
[#23]: https://github.com/terraform-google-modules/terraform-google-network/pull/23
[#19]: https://github.com/terraform-google-modules/terraform-google-network/pull/19
[#14]: https://github.com/terraform-google-modules/terraform-google-network/pull/14
[#13]: https://github.com/terraform-google-modules/terraform-google-network/pull/13
[#6]: https://github.com/terraform-google-modules/terraform-google-network/pull/6
[keepachangelog-site]: https://keepachangelog.com/en/1.0.0/
[semver-site]: https://semver.org/spec/v2.0.0.html
