## [Unreleased]
### Fixed
- Resolved issue with networks that have no secondary networks (#19)

## 0.4.0
### Changed
- Make `subnet_private_access` and `subnet_flow_logs` into strings to be consistent with `shared_vpc` flag (#13)

## 0.3.0
### Added
- Add support for controlling subnet flow logs (#6)

### Changed
- Make `subnet_private_access` default to false (#6)

## 0.2.0
### Added
- Add support for Shared VPC hosting

## 0.1.0

### Added
- Initial release
- A Google Virtual Private Network (VPC)
- Subnets within the VPC
- Secondary ranges for the subnets (if applicable)
