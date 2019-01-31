# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this
project adheres to [Semantic Versioning](http://semver.org/).

## [0.5.0]
### CHANGED
- Make `routing_mode` a configurable variable. Defaults to "GLOBAL" [#26]

### ADDED
- Subnet self links as outputs. [#27]
- Support for route creation [#14]
- Add example for VPC with many secondary ranges [#23]
- Add example for VPC with regional routing mode [#26]

### FIXED
- Resolved issue with networks that have no secondary networks [#19]

## [0.4.0]
### CHANGED
- Make `subnet_private_access` and `subnet_flow_logs` into strings to be consistent with `shared_vpc` flag [#13]

## [0.3.0]
### CHANGED
- Make `subnet_private_access` default to false [#6]

### ADDED
- Add support for controlling subnet flow logs [#6]

## [0.2.0]
### ADDED
- Add support for Shared VPC hosting

## [0.1.0]
### ADDED
- Initial release
- A Google Virtual Private Network (VPC)
- Subnets within the VPC
- Secondary ranges for the subnets (if applicable)
