# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

## [7.1.0](https://github.com/terraform-google-modules/terraform-google-network/compare/v7.0.0...v7.1.0) (2023-06-27)


### Features

* add destination_ranges and source_ranges in firewall rules ([#464](https://github.com/terraform-google-modules/terraform-google-network/issues/464)) ([83a7e85](https://github.com/terraform-google-modules/terraform-google-network/commit/83a7e85ec0085309d41e103d959eecf17c7a6b14))
* added network firewall policy sub-module ([#453](https://github.com/terraform-google-modules/terraform-google-network/issues/453)) ([7b197c6](https://github.com/terraform-google-modules/terraform-google-network/commit/7b197c6448c13bb5664f7865d42890b8d2fba7e1))

## [7.0.0](https://github.com/terraform-google-modules/terraform-google-network/compare/v6.0.1...v7.0.0) (2023-04-13)


### ⚠ BREAKING CHANGES

* **TF >= 1.3:** allow optional vars in firewall rules module ([#438](https://github.com/terraform-google-modules/terraform-google-network/issues/438))
* **TPG >=4.25:** add IPv6 support ([#420](https://github.com/terraform-google-modules/terraform-google-network/issues/420))

### Features

* **TPG >=4.25:** add IPv6 support ([#420](https://github.com/terraform-google-modules/terraform-google-network/issues/420)) ([4470952](https://github.com/terraform-google-modules/terraform-google-network/commit/447095261290c25dae760cabfda5f21d941f0826))


### Bug Fixes

* **TF >= 1.3:** allow optional vars in firewall rules module ([#438](https://github.com/terraform-google-modules/terraform-google-network/issues/438)) ([b188d37](https://github.com/terraform-google-modules/terraform-google-network/commit/b188d37aa20a6975b465dde016656e22321b9432))

## [6.0.1](https://github.com/terraform-google-modules/terraform-google-network/compare/v6.0.0...v6.0.1) (2022-12-30)


### Bug Fixes

* align subnet modules ([#412](https://github.com/terraform-google-modules/terraform-google-network/issues/412)) ([36d1c55](https://github.com/terraform-google-modules/terraform-google-network/commit/36d1c553ba757f8b3d73632e32b81395949de66c))
* fixes lint issues and generates metadata ([#411](https://github.com/terraform-google-modules/terraform-google-network/issues/411)) ([f29b20c](https://github.com/terraform-google-modules/terraform-google-network/commit/f29b20c1242602d5e6b2a99ece7800661053aa26))

## [6.0.0](https://github.com/terraform-google-modules/terraform-google-network/compare/v5.2.0...v6.0.0) (2022-11-21)


### ⚠ BREAKING CHANGES

* update minimum TPG version to 3.33 for firewall-rules #381
* increase subnets module minimum TPG to 2.15 (#377)

### Bug Fixes

* increase subnets module minimum TPG to 2.15 ([#377](https://github.com/terraform-google-modules/terraform-google-network/issues/377)) ([3978cf1](https://github.com/terraform-google-modules/terraform-google-network/commit/3978cf1c5d834e158423ce525f6782e4550e1c23))
* update minimum TPG version to 3.33 for firewall-rules [#381](https://github.com/terraform-google-modules/terraform-google-network/issues/381) ([0640fdd](https://github.com/terraform-google-modules/terraform-google-network/commit/0640fdd36173d196054135c997f0feba851fb4a3))

## [5.2.0](https://github.com/terraform-google-modules/terraform-google-network/compare/v5.1.0...v5.2.0) (2022-07-28)


### Features

* add private service connect module ([#368](https://github.com/terraform-google-modules/terraform-google-network/issues/368)) ([4e90bee](https://github.com/terraform-google-modules/terraform-google-network/commit/4e90bee24bad734ec9a8c99f32902b5904f68796))

## [5.1.0](https://github.com/terraform-google-modules/terraform-google-network/compare/v5.0.0...v5.1.0) (2022-05-16)


### Features

* add filter_expr control in subnet log_config ([#360](https://github.com/terraform-google-modules/terraform-google-network/issues/360)) ([5f7e227](https://github.com/terraform-google-modules/terraform-google-network/commit/5f7e22782c8f22e5d4f1a6ed448ae70e91a26b8d))

## [5.0.0](https://github.com/terraform-google-modules/terraform-google-network/compare/v4.1.0...v5.0.0) (2022-02-04)


### ⚠ BREAKING CHANGES

* update min TPG versions 3.83 (#349)

### Bug Fixes

* update min TPG versions 3.83 ([#349](https://github.com/terraform-google-modules/terraform-google-network/issues/349)) ([74efa6a](https://github.com/terraform-google-modules/terraform-google-network/commit/74efa6a63ed3f2068c3ecf85fc55a914afcd4be2))

## [4.1.0](https://github.com/terraform-google-modules/terraform-google-network/compare/v4.0.1...v4.1.0) (2022-01-18)


### Features

* Promote role and purpose of subnet to GA ([#343](https://github.com/terraform-google-modules/terraform-google-network/issues/343)) ([8b98a36](https://github.com/terraform-google-modules/terraform-google-network/commit/8b98a36eecef8d29c7a2435d1b0809cbd8e1ba6f))

### [4.0.1](https://www.github.com/terraform-google-modules/terraform-google-network/compare/v4.0.0...v4.0.1) (2021-11-11)


### Bug Fixes

* Update Google provider constraints to allow 4.x ([#335](https://www.github.com/terraform-google-modules/terraform-google-network/issues/335)) ([9c07970](https://www.github.com/terraform-google-modules/terraform-google-network/commit/9c07970ea8be848bdee4071a3f3d417d5e4c1a9a))

## [4.0.0](https://www.github.com/terraform-google-modules/terraform-google-network/compare/v3.5.0...v4.0.0) (2021-10-25)


### ⚠ BREAKING CHANGES

* shared_vpc attachments in the `fabric-net-svpc-access` submodule have been refactored, changing the state location.

### Bug Fixes

* require google-beta also in the root module, not just in vpc module ([#327](https://www.github.com/terraform-google-modules/terraform-google-network/issues/327)) ([e28f1e5](https://www.github.com/terraform-google-modules/terraform-google-network/commit/e28f1e511c42587b4e1cd64b43e6ffe925be423e))
* use for_each for shared VPC service project connections ([#329](https://www.github.com/terraform-google-modules/terraform-google-network/issues/329)) ([3f400af](https://www.github.com/terraform-google-modules/terraform-google-network/commit/3f400aff1c4ae91569d9357415960380a0d2036a))

## [3.5.0](https://www.github.com/terraform-google-modules/terraform-google-network/compare/v3.4.0...v3.5.0) (2021-10-06)


### Features

* Add max_throughput to vpc-serverless-connector-beta ([#322](https://www.github.com/terraform-google-modules/terraform-google-network/issues/322)) ([1cc50ca](https://www.github.com/terraform-google-modules/terraform-google-network/commit/1cc50ca5c9ce5a1c33b30e4f24fa6b562688afd2))

## [3.4.0](https://www.github.com/terraform-google-modules/terraform-google-network/compare/v3.3.0...v3.4.0) (2021-08-13)


### Features

* add top-level output network_id from the vpc module ([#315](https://www.github.com/terraform-google-modules/terraform-google-network/issues/315)) ([be66cf4](https://www.github.com/terraform-google-modules/terraform-google-network/commit/be66cf4b6d6173b9736bc11746c8a8b304441574))


### Bug Fixes

* **fabric:** Replaced `count` with `for_each` on `google_compute_subnetwork_iam_binding` to prevent destroy/recreate when the list changes. ([#311](https://www.github.com/terraform-google-modules/terraform-google-network/issues/311)) ([ead88f8](https://www.github.com/terraform-google-modules/terraform-google-network/commit/ead88f802123be56dfc9f8ee7b06a3d67d9f7017))

## [3.3.0](https://www.github.com/terraform-google-modules/terraform-google-network/compare/v3.2.2...v3.3.0) (2021-06-01)


### Features

* Adding vpc-serverless-connector-submodule-beta ([#280](https://www.github.com/terraform-google-modules/terraform-google-network/issues/280)) ([3f720fa](https://www.github.com/terraform-google-modules/terraform-google-network/commit/3f720fa5d44639f5605b1b5b07a92bedad0f67ca))


### Bug Fixes

* adds `subnet_ids` as an output ([#299](https://www.github.com/terraform-google-modules/terraform-google-network/issues/299)) ([fe89ce6](https://www.github.com/terraform-google-modules/terraform-google-network/commit/fe89ce6e0b7155cc481c95359eb1b5b78310d1bc))

### [3.2.2](https://www.github.com/terraform-google-modules/terraform-google-network/compare/v3.2.1...v3.2.2) (2021-04-24)


### Bug Fixes

* Add variable type for http_target_tags variable ([#276](https://www.github.com/terraform-google-modules/terraform-google-network/issues/276)) ([08842fa](https://www.github.com/terraform-google-modules/terraform-google-network/commit/08842fab8810f1d304a82328f145fac4bc2d10cf))

### [3.2.1](https://www.github.com/terraform-google-modules/terraform-google-network/compare/v3.2.0...v3.2.1) (2021-04-08)


### Bug Fixes

* Switch shared_vpc resources to beta provider in access submodule ([#269](https://www.github.com/terraform-google-modules/terraform-google-network/issues/269)) ([5b00673](https://www.github.com/terraform-google-modules/terraform-google-network/commit/5b006736344bb125c2416c7a5d37038798112374))

## [3.2.0](https://www.github.com/terraform-google-modules/terraform-google-network/compare/v3.1.2...v3.2.0) (2021-03-04)


### Features

* Add support for export_local_subnet_routes_with_public_ip and export_peer_subnet_routes_with_public_ip ([#255](https://www.github.com/terraform-google-modules/terraform-google-network/issues/255)) ([8666553](https://www.github.com/terraform-google-modules/terraform-google-network/commit/8666553e0912af92e072eef9fa8c75e754af6f1b))

### [3.1.2](https://www.github.com/terraform-google-modules/terraform-google-network/compare/v3.1.1...v3.1.2) (2021-02-25)


### Bug Fixes

* Eliminate deprecation warning due to pre-0.12 string interpolation syntax ([#249](https://www.github.com/terraform-google-modules/terraform-google-network/issues/249)) ([1d833dc](https://www.github.com/terraform-google-modules/terraform-google-network/commit/1d833dc85cbea9052f239f328951c8f19ad4a382))

### [3.1.1](https://www.github.com/terraform-google-modules/terraform-google-network/compare/v3.1.0...v3.1.1) (2021-02-16)


### Bug Fixes

* Allow next_hop_gateway to be passed for non-internet routes ([#242](https://www.github.com/terraform-google-modules/terraform-google-network/issues/242)) ([08d7167](https://www.github.com/terraform-google-modules/terraform-google-network/commit/08d716724ec43eb70f8c6a16481328a3145fba6f))
* Update required Terraform version for firewall-rules submodule ([#245](https://www.github.com/terraform-google-modules/terraform-google-network/issues/245)) ([6a86ae2](https://www.github.com/terraform-google-modules/terraform-google-network/commit/6a86ae2fc58a579c7da4aec634929e58a8fdfa7e))

## [3.1.0](https://www.github.com/terraform-google-modules/terraform-google-network/compare/v3.0.1...v3.1.0) (2021-02-10)


### Features

* Add dedicated custom firewall rules module ([#200](https://www.github.com/terraform-google-modules/terraform-google-network/issues/200)) ([24f2a0f](https://www.github.com/terraform-google-modules/terraform-google-network/commit/24f2a0f2e133052ebf485edeb5b1f0ffa69a5829))
* add next_hop_ilb to routes module ([#241](https://www.github.com/terraform-google-modules/terraform-google-network/issues/241)) ([87c8215](https://www.github.com/terraform-google-modules/terraform-google-network/commit/87c8215da8d7b7ba0bbbb6136ba77c6e047ca2f0))
* Add support for enabling firewall logging on each rule ([#236](https://www.github.com/terraform-google-modules/terraform-google-network/issues/236)) ([2f44790](https://www.github.com/terraform-google-modules/terraform-google-network/commit/2f44790af2936887356dc7ed6b5f1cb343a7e578))

### [3.0.1](https://www.github.com/terraform-google-modules/terraform-google-network/compare/v3.0.0...v3.0.1) (2021-01-15)


### Bug Fixes

* Automatically truncate VPC peering name if necessary ([#229](https://www.github.com/terraform-google-modules/terraform-google-network/issues/229)) ([67e833a](https://www.github.com/terraform-google-modules/terraform-google-network/commit/67e833a701fb4bc36aaeebbf88daea9a6f5e97b0))
* By default, accept standard API MTU configuration of 1460 ([#226](https://www.github.com/terraform-google-modules/terraform-google-network/issues/226)) ([26507ba](https://www.github.com/terraform-google-modules/terraform-google-network/commit/26507ba861c24e190bf52d02c483786e7b660faa))

## [3.0.0](https://www.github.com/terraform-google-modules/terraform-google-network/compare/v2.6.0...v3.0.0) (2020-12-29)


### ⚠ BREAKING CHANGES

* Minimum Terraform version increased to 0.13.
* Minimum Google provider version increased to 3.45.0.

### Features

* Add support for custom MTU on VPCs ([#221](https://www.github.com/terraform-google-modules/terraform-google-network/issues/221)) ([bb31529](https://www.github.com/terraform-google-modules/terraform-google-network/commit/bb315290b84a06302b9fd844915853a373cf5abc))


### Miscellaneous Chores

* add Terraform 0.13 constraint and module attribution ([#224](https://www.github.com/terraform-google-modules/terraform-google-network/issues/224)) ([6c835be](https://www.github.com/terraform-google-modules/terraform-google-network/commit/6c835be46fe154d3e90211c503fe671174da9551))

## [2.6.0](https://www.github.com/terraform-google-modules/terraform-google-network/compare/v2.5.0...v2.6.0) (2020-12-08)


### Features

* Setting default values for Flow logs on beta submodule ([#209](https://www.github.com/terraform-google-modules/terraform-google-network/issues/209)) ([1a2d1b5](https://www.github.com/terraform-google-modules/terraform-google-network/commit/1a2d1b5c3badb58a87ae845afa2123f26f64d093))
* Added support for Terraform 0.14 ([#217](https://github.com/terraform-google-modules/terraform-google-network/pull/217))

## [2.5.0](https://www.github.com/terraform-google-modules/terraform-google-network/compare/v2.4.0...v2.5.0) (2020-08-11)


### Features

* Allow passing target_tags to configure the default firewall rules ([#191](https://www.github.com/terraform-google-modules/terraform-google-network/issues/191)) ([996b4f1](https://www.github.com/terraform-google-modules/terraform-google-network/commit/996b4f179e4ac2751e1690a43b41e687759dff8d))


### Bug Fixes

* Add support for 3.x provider to beta subnets module ([#194](https://www.github.com/terraform-google-modules/terraform-google-network/issues/194)) ([4957536](https://www.github.com/terraform-google-modules/terraform-google-network/commit/49575366d3a57ded474f0417e14eb13875eda304))
* Relax Terraform version to allow 0.13  ([#197](https://www.github.com/terraform-google-modules/terraform-google-network/issues/197)) ([1a77919](https://www.github.com/terraform-google-modules/terraform-google-network/commit/1a77919fadd46c658adb9e94da0b121b4b924aaf))

## [2.4.0](https://www.github.com/terraform-google-modules/terraform-google-network/compare/v2.3.0...v2.4.0) (2020-06-01)


### Features

* Switch default route deletion to use native method. ([#185](https://www.github.com/terraform-google-modules/terraform-google-network/issues/185)) ([c1d786f](https://www.github.com/terraform-google-modules/terraform-google-network/commit/c1d786fe0743d205911d7c592b8f7c406ad45be2))
  - Route deletion has now been moved to the VPC module. Hence, you must *remove* calls to `delete_default_internet_gateway_routes` from
  any usage of the routes submodule


### Bug Fixes

* Remove quoted references ([#183](https://www.github.com/terraform-google-modules/terraform-google-network/issues/183)) ([7e5f5ab](https://www.github.com/terraform-google-modules/terraform-google-network/commit/7e5f5ab9fa4f19b4995ae24c9db1234dbdbcb487))
* Resolve Invalid index error on shared vpc destroy ([#177](https://www.github.com/terraform-google-modules/terraform-google-network/issues/177)) ([b799266](https://www.github.com/terraform-google-modules/terraform-google-network/commit/b799266146daffa3ba75f3fb5c7920c5f1df165c))

## [2.3.0](https://www.github.com/terraform-google-modules/terraform-google-network/compare/v2.2.0...v2.3.0) (2020-04-16)


### Features

* Add beta provider support for routes and subnets ([#124](https://www.github.com/terraform-google-modules/terraform-google-network/issues/124)) ([6c94a6f](https://www.github.com/terraform-google-modules/terraform-google-network/commit/6c94a6fd89989d1dd113e0a156f0c5d7cdd8407e)), closes [#68](https://www.github.com/terraform-google-modules/terraform-google-network/issues/68)

## [2.2.0](https://www.github.com/terraform-google-modules/terraform-google-network/compare/v2.1.2...v2.2.0) (2020-04-07)


### Features

* add network output ([#169](https://www.github.com/terraform-google-modules/terraform-google-network/issues/169)) ([0dc6965](https://www.github.com/terraform-google-modules/terraform-google-network/commit/0dc6965ab52f946b9e3d16dc8f8e3557d369da01))

### [2.1.2](https://www.github.com/terraform-google-modules/terraform-google-network/compare/v2.1.1...v2.1.2) (2020-04-02)


### Bug Fixes

* Add support for enable_logging on firewall rules ([#155](https://www.github.com/terraform-google-modules/terraform-google-network/issues/155)) ([febec4e](https://www.github.com/terraform-google-modules/terraform-google-network/commit/febec4ef4b2d6080b18429106b19a8fbc5452bec))
* Add variables type as first parameter on all variables ([#167](https://www.github.com/terraform-google-modules/terraform-google-network/issues/167)) ([2fff1e7](https://www.github.com/terraform-google-modules/terraform-google-network/commit/2fff1e7cd5188e24a413bc302c8a061c4f3bb19b))
* remove invalid/outdated create_network variable ([#159](https://www.github.com/terraform-google-modules/terraform-google-network/issues/159)) ([6fac78e](https://www.github.com/terraform-google-modules/terraform-google-network/commit/6fac78e5b25a2ab72824b0ebefff6704a46fd984))
* Resolve error with destroy and shared VPC host config ([#168](https://www.github.com/terraform-google-modules/terraform-google-network/issues/168)) ([683ae07](https://www.github.com/terraform-google-modules/terraform-google-network/commit/683ae072382c03f8b032944e539e9fa8601bad1f)), closes [#163](https://www.github.com/terraform-google-modules/terraform-google-network/issues/163)

### [2.1.1](https://www.github.com/terraform-google-modules/terraform-google-network/compare/v2.1.0...v2.1.1) (2020-02-04)


### Bug Fixes

* Correct the service_project_ids type ([#152](https://www.github.com/terraform-google-modules/terraform-google-network/issues/152)) ([80b6f54](https://www.github.com/terraform-google-modules/terraform-google-network/commit/80b6f54c007bc5b89709a9eebe330af058ca2260))
* Resolve "Invalid expanding argument value" issue with the newer versions of terraform ([#153](https://www.github.com/terraform-google-modules/terraform-google-network/issues/153)) ([5f61ffb](https://www.github.com/terraform-google-modules/terraform-google-network/commit/5f61ffb3cb03a4d0ddb02dde1a3085aa428aeb38))

## [2.1.0](https://www.github.com/terraform-google-modules/terraform-google-network/compare/v2.0.2...v2.1.0) (2020-01-31)


### Features

* add subnets output with full subnet info ([#129](https://www.github.com/terraform-google-modules/terraform-google-network/issues/129)) ([b424186](https://www.github.com/terraform-google-modules/terraform-google-network/commit/b4241861d8e670d555a43b82f4451581a8e27367))


### Bug Fixes

* Make project_id output dependent on shared_vpc host enablement ([#150](https://www.github.com/terraform-google-modules/terraform-google-network/issues/150)) ([75f9f04](https://www.github.com/terraform-google-modules/terraform-google-network/commit/75f9f0494c2a17b6d53fb265b3a4c77490b2914b))

### [2.0.2](https://github.com/terraform-google-modules/terraform-google-network/compare/v2.0.1...v2.0.2) (2020-01-21)


### Bug Fixes

* relax version constraint in README ([1a39c7d](https://github.com/terraform-google-modules/terraform-google-network/commit/1a39c7df1d9d12e250500c3321e82ff78b0cd900))

## [2.0.1] - 2019-12-18

### Fixed

- Fixed bug for allowing internal firewall rules. [#123](https://github.com/terraform-google-modules/terraform-google-network/pull/123)
- Provided Terraform provider versions and relaxed version constraints. [#131](https://github.com/terraform-google-modules/terraform-google-network/pull/131)

## [2.0.0](https://github.com/terraform-google-modules/terraform-google-network/compare/v1.5.0...v2.0.0) (2019-12-09)

v2.0.0 is a backwards-incompatible release. Please see the [upgrading guide](./docs/upgrading_to_v2.0.md).

### Added

- Split main module up into vpc, subnets, and routes submodules. [#103]

### Fixed

- Fixes subnet recreation when a subnet is updated. [#73]


## [1.5.0](https://github.com/terraform-google-modules/terraform-google-network/compare/v1.3.0...v1.5.0) (2019-11-12)

### Added

- Added submodule `network-peering` [#101]

## [1.4.3] - 2019-10-31

### Fixed

- Fixed issue with depending on outputs introduced in 1.4.1. [#95]

## [1.4.2] - 2019-10-30

### Fixed

- The outputs `network_name`, `network_self_link`, and
  `subnets_secondary_ranges` depend on resource attributes rather than
  data source attributes when `create_network` = `true`. [#94]

## [1.4.1] - 2019-10-29

### Added

- Made network creation optional in root module. [#88]

### Fixed

- Fixed issue with depending on outputs introduced in 1.4.0. [#92]

## [1.4.0] - 2019-10-14

### Added

- Add dynamic firewall rules support to firewall submodule. [#79]

### Fixed

- Add `depends_on` to `created_subnets` data fetch (fixes issue [#80]). [#81]

## [1.3.0](https://github.com/terraform-google-modules/terraform-google-network/compare/v1.2.0...v1.3.0) (2019-10-10)

### Changed

- Set default value for `next_hop_internet`. [#64]

### Added

- Add host service agent role management to Shared VPC submodule [#72]

## 1.2.0 (2019-09-18)

### Added

- Added `description` variable for subnets. [#66]

### Fixed

- Made setting `secondary_ranges` optional. [#16]

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

[Unreleased]: https://github.com/terraform-google-modules/terraform-google-network/compare/v2.0.1...HEAD
[2.0.1]: https://github.com/terraform-google-modules/terraform-google-network/compare/v2.0.0...v2.0.1
[2.0.0]: https://github.com/terraform-google-modules/terraform-google-network/compare/v1.5.0...v2.0.0
[1.5.0]: https://github.com/terraform-google-modules/terraform-google-network/compare/v1.4.3...v1.5.0
[1.4.3]: https://github.com/terraform-google-modules/terraform-google-network/compare/v1.4.2...v1.4.3
[1.4.2]: https://github.com/terraform-google-modules/terraform-google-network/compare/v1.4.1...v1.4.2
[1.4.1]: https://github.com/terraform-google-modules/terraform-google-network/compare/v1.4.0...v1.4.1
[1.4.0]: https://github.com/terraform-google-modules/terraform-google-network/compare/v1.3.0...v1.4.0
[1.3.0]: https://github.com/terraform-google-modules/terraform-google-network/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/terraform-google-modules/terraform-google-network/compare/v1.1.0...v1.2.0
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

[#73]: https://github.com/terraform-google-modules/terraform-google-network/pull/73
[#103]: https://github.com/terraform-google-modules/terraform-google-network/pull/103
[#101]: https://github.com/terraform-google-modules/terraform-google-network/pull/101
[#95]: https://github.com/terraform-google-modules/terraform-google-network/issues/95
[#94]: https://github.com/terraform-google-modules/terraform-google-network/pull/94
[#92]: https://github.com/terraform-google-modules/terraform-google-network/issues/92
[#88]: https://github.com/terraform-google-modules/terraform-google-network/issues/88
[#81]: https://github.com/terraform-google-modules/terraform-google-network/pull/81
[#80]: https://github.com/terraform-google-modules/terraform-google-network/issues/80
[#79]: https://github.com/terraform-google-modules/terraform-google-network/pull/79
[#72]: https://github.com/terraform-google-modules/terraform-google-network/pull/72
[#64]: https://github.com/terraform-google-modules/terraform-google-network/pull/64
[#66]: https://github.com/terraform-google-modules/terraform-google-network/pull/66
[#16]: https://github.com/terraform-google-modules/terraform-google-network/pull/16
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
