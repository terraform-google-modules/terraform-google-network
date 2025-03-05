# 2025-02-15 i868402
* Update Base Container Versions
* Update Package Versions
* Updated Buglist
  * Further details on Ansible / Python issues

# 2025-01-15 i868402
* Stubbed implementation for future replacement of TFENV with TENV
* Update AWS CLI to 2.22.23
* Use explicit tofu binary to download providers instead of TENV or TFENV
* Add sshpass for ansible
* Ansible AWS Collection Downgrades for Compatability. (8.x.x)
* Other ansible collection and python minor upgrades.
* Started a buglist tracking document

# 2024-12-15 i868402
* Downgrade Ansible-Core to 2.16.xx due to RHEL8 Bug
* Update CLI Tools
* Update Collections
* Update Base Container Version
* Update Tofu Version

# 2024-11-18 i868402
* Downgrade Ansible Azure Collection to 2.7.0 due to bug in 3.0.0
* Allow Terraform Init to pull providers outside of local mirror
* Added Terraform Provider HTTP

# 2024-11-15 i868402
* Further optimzation of Docker code.
* Moved PIP Requirements to file
* Moved Ansible Collection Requirements to file
* Version pinned most packages.
* Added Local Providers Mirror

# Version 1.4.0 (2024-10-20) (i868402)
* Forked opentofu out of generic_workspace into it's own container.
* Made opentofu multi-platform.
* add ansible collection `community.aws`
* add python `boto3`
* Update Python Version
* Update Ansible Collection Versions
