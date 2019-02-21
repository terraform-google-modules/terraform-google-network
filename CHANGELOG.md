# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][keepachangelog-site],
and this project adheres to [Semantic Versioning][semver-site].

## [Unreleased]

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

## 0.1.0 - 2018-08-08

### Added

- Initial release
- A Google Virtual Private Network (VPC)
- Subnets within the VPC
- Secondary ranges for the subnets (if applicable)

[Unreleased]: https://github.com/terraform-google-modules/terraform-google-network/compare/v0.6.0...HEAD
[0.6.0]: https://github.com/terraform-google-modules/terraform-google-network/compare/v0.5.0...v0.6.0
[0.5.0]: https://github.com/terraform-google-modules/terraform-google-network/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/terraform-google-modules/terraform-google-network/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/terraform-google-modules/terraform-google-network/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/terraform-google-modules/terraform-google-network/compare/v0.1.0...v0.2.0
[keepachangelog-site]: https://keepachangelog.com/en/1.0.0/
[semver-site]: https://semver.org/spec/v2.0.0.html
