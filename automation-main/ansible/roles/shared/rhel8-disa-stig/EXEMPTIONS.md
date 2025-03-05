# DISA STIG Exemptions for Red Hat Enterprise (RHEL) 8

## Purpose

This list is being maintained by SAP Sovereign Cloud Services (SCS) to justify which specific DISA STIGS will not be applied to Red Hat Enterprise 8 images. This will be manually recorded until we are able to auto-generate a STIG checklist file with output from an OpenSCAP scan and insert these manual comments in as exemptions. The list is ordered by the STIG ID and includes the Rule ID for mapping with various security tools with a custom title to support multi-rule exemptions.

### OpenSSH Cipher List

__Description__

The RHEL 8 operating system must implement DoD-approved encryption to protect the confidentiality of SSH server connections.

__Applicable STIGS__

RHEL-08-010291 - SV-230252r743940

__Justification__

The accepted ciphers listed in the OpenSSH config file has been configured to match only FIPS 140-2 encryption algorithms in accordance with DoD guidance. However, the Nessus checks are failing due to poor regex that fails to consider the contents of the OpenSSH config file unrelated to SSH ciphers.

### Vendor Supported Release

__Description__

The RHEL 8 must be a vendor-supported release.

__Applicable STIGS__

RHEL-08-010000 - SV-230221r599732

__Defective Detection__

Tenable Nessus

__Justification__

This is most likely a false positive due to the fact that the definitions are looking for a specific release. Newer releases may not be included and thus will cause this check to fail. For instance, if DISA released their STIG in September and Red Hat released a minor version in October, this check will fail since DISA has not recognized the new minor release.

### Data Encryption at Rest

__Description__

All RHEL 8 local disk partitions must implement cryptographic mechanisms to prevent unauthorized disclosure or modification of all information that requires at rest protection.

__Applicable STIGS__

RHEL-08-010030 - SV-230224r599732

__Justification__

Depending on the purpose of the system, the underlying data volumes are encrypted. In some instances the cloud provider root volume is also encrypted e.g., AWS EBS Volume encryption through AWS KMS.

### USG/DOD Login Banner

__Description__

RHEL 8 must display the Standard Mandatory DoD Notice and Consent Banner before granting local or remote access to the system via a command line/graphical/ssh logon.

__Applicable STIGS__

RHEL-08-010040 - SV-230225r599732
RHEL-08-010050 - SV-230226r599732
RHEL-08-010060 - SV-230227r599732

__Defective Detection__

OpenSCAP, Tenable Nessus

__Justification__

The login banner has been configured to the United States Government (USG) guidance but the Nessus checks are failing due to poor regex. Other banners are available within the Ansible role but is not configured by default.

### DOD Root Certificate Authority

__Description__

RHEL 8, for PKI-based authentication, must validate certificates by constructing a certification path (which includes status information) to an accepted trust anchor.

__Applicable STIGS__

RHEL-08-010090 - SV-230229r627750

__Justification__

DOD Root Certificate Authority (CA) is included during the provisioning process for specific environments.

### Password Protected Private Keys

__Description__

RHEL 8, for certificate-based authentication, must enforce authorized access to the corresponding private key. If an unauthorized user obtains access to a private key without a passcode, that user would have unauthorized access to any system where the associated public key has been installed.

__Applicable STIGS__

RHEL-08-010100 - SV-230230r627750

__Justification__

Private key material is not included in the base image.

### BIOS/UEFI Password for Single User Mode

__Description__

RHEL 8 operating systems booted with United Extensible Firmware Interface (UEFI) implemented must require authentication upon booting into single-user mode and maintenance. If the system does not require valid root authentication before it boots into single-user or maintenance mode, anyone who invokes single-user or maintenance mode is granted privileged access to all files on the system. GRUB 2 is the default boot loader for RHEL 8 and is designed to require a password to boot into single-user mode or make modifications to the boot menu.

__Applicable STIGS__

RHEL-08-010140 - SV-230234r743922
RHEL-08-010150 - SV-230235r743925

__Justification__

These servers are being hosted within hyperscalers e.g., AWS GovCloud, Azure Government, Google Cloud Platform and thus this control is not applicable. The physical access controls in place by the hyperscalers for their datacenters and how the hypervisors are configured should be sufficient justification for not applying a GRUB password.

### SELINUX State

__Description__

RHEL8 must use a Linux Security Module configured to enforce limits on system services.

__Applicable STIGS__

RHEL-08-010170 - SV-230240r627750

__Justification__

Due to organizational requirements SELINUX must be placed into permissive mode which logs all actions otherwise blocked by enforcing mode.

### SSH Inactivity

__Description__

RHEL 8 must be configured so that all network connections associated with SSH traffic are terminated at the end of the session or after 10 minutes of inactivity, except to fulfill documented and validated mission requirements.

__Applicable STIGS__

RHEL-08-010200 - SV-230244r743934

__Justification__

Due to organizational requirements ssh must not forcibly disconnect sessions until the system has been fully provisioned. Application installations often are conducted remotely over ssh with executions often being disrupted during provisioning.

### Var Log Directory Permissions

__Description__

 The RHEL 8 /var/log directory must have mode 0770 or less permissive.

__Applicable STIGS__

RHEL-08-010240 - SV-230248r627750

__Justification__

clamav, which runs as user clamupdate group freshclam, needs to be able to write it's logfile to /var/log.

### Root Owned System Commands

__Description__

If RHEL 8 were to allow any user to make changes to software libraries, then those changes might be implemented without undergoing the appropriate testing and approvals that are part of a robust change management process. Therefore, RHEL 8 system commands must be group-owned by root.

__Applicable STIGS__

RHEL-08-010320 - SV-230259r599732

__Justification__

The `/usr/bin/locate`, `/usr/bin/screen`, and `/usr/bin/write` binaries are owned by groups, slocate, screen, and tty root and must remain so for proper function in RHEL8. Automation has been modified to exclude these specific instances but will properly report any other deviations.

### Passwordless Sudoers

__Description__

RHEL 8 must require users to reauthenticate for privilege escalation and changing roles.

__Applicable STIGS__

RHEL-08-010380 - SV-230271r627750

__Justification__

In order for our automation to function we require both ec2-user and ssm-users to be able to invoke passwordless sudo.

### Seperate Filesystem for Temporary Directory

__Description__

RHEL 8 must use a separate file system for `/var/tmp`. The use of separate file systems for different paths can protect the system from failures resulting from a file system becoming full or failing.

__Applicable STIGS__

RHEL-08-010544 - SV-244529r743836

__Justification__

The directory `/var/tmp` is not to be directly used by individuals or applications within the organization. The `/var` directory containing `/var/tmp` has been properly sized to accommodate this directory.

### Noexec on Home Directory

__Description__

The "noexec" mount option causes the system not to execute binary files. This option must be used for mounting any file system not containing approved binary files, as they may be incompatible. Executing files from untrusted file systems increases the opportunity for unprivileged users to attain unauthorized administrative access.

__Applicable STIGS__

RHEL-08-010590 - SV-230302r599732

__Justification__

Configuration should be applied post-deployment as inclusion into the base image could cause provisioning issues.

### Multiple Name Servers Configured

__Description__

To provide availability for name resolution services, multiple redundant name servers are mandated. A failure in name resolution could lead to the failure of security functions requiring name resolution, which may include time synchronization, centralized authentication, and remote system logging.

__Applicable STIGS__

RHEL-08-010680 - SV-230316r627750

__Justification__

Configuration should be applied post-deployment as the available name servers vary between environments.

### Temporary User Accounts - General

__Description__

RHEL 8 temporary user accounts must be provisioned with an expiration time of 72 hours or less.

__Applicable STIGS__

RHEL-08-020000 - SV-230331r599824

__Justification__

Temporary user accounts are not included in the base image.

### Lock User Accounts After Three Failed Login Attempts

__Description__

RHEL 8 must automatically lock an account when three unsuccessful logon attempts occur.

__Applicable STIGS__

RHEL-08-020010 - SV-230332r627750
RHEL-08-020011 - SV-230333r743966

__Justification__

The system should be configured with this STIG after it has been successfully deployed to an environment to avoid any issues or delays during the deployment process.

### Session Locking with tmux

__Description__

A session lock is a temporary action taken when a user stops work and moves away from the immediate physical vicinity of the information system but does not want to log out because of the temporary nature of the absence.

__Applicable STIGS__

RHEL-08-020039 - SV-244537r743860
RHEL-08-020041 - SV-230349r599732
RHEL-08-020050 - SV-230351r599792
RHEL-08-020060 - SV-230352r646876
RHEL-08-020070 - SV-230353r599732

__Justification__

Session inactivity is managed through SSH as interactive unix accounts will be adversely affected through the application of this setting.

### Session locking with Smart Cards

__Description__

RHEL 8 must be able to initiate directly a session lock for all connection types using smartcard when the smartcard is removed.

__Applicable STIGS__

RHEL-08-020050 - SV-230351r599792

__Justification__

Depending on where the system has been deployed, there may already be mitigating controls in place to handle multifactor authentication to restrict access to the environment where the system is being hosted. Configuration should be applied post-deployment as inclusion into the base image could cause provisioning issues.

### SSSD Configuration for DOD PKI-based MFA

__Description__

RHEL 8 must map the authenticated identity to the user or group account for PKI-based authentication. Without mapping the certificate used to authenticate to the user account, the ability to determine the identity of the individual user or group will not be available for forensic analysis.s

__Applicable STIGS__

RHEL-08-020090 - SV-230355r599732

__Justification__

Depending on where the system has been deployed, there may already be mitigating controls in place to handle multifactor authentication to restrict access to the environment where the system is being hosted. Configuration should be applied post-deployment as inclusion into the base image could cause provisioning issues. Some environments leverage HashiCorp Vault SSH Engines where domain authentication and hardware-based multifactor authentication grant temporary SSH privileges through short-lived certificates.

### Minimum Password Lifetime

__Description__

RHEL 8 passwords must have a 24 hours/1 day minimum password lifetime restriction in `/etc/shadow`.

__Applicable STIGS__

RHEL-08-020180 - SV-230364r599732

__Justification__

Tenable Nessus is incorrectly picking up `ec2-user` and `nfsnobody` as users with passwords enabled.

### Maximum Password Lifetime (New and Existing Users)

__Description__

The Red Hat Enterprise Linux operating system must be configured so that passwords for new users are restricted to a 60-day maximum lifetime.

__Applicable STIGS__

RHEL-08-020200 - SV-230366r599732
RHEL-08-020210 - SV-230367r599732

__Justification__

The maximum password lifetime for new and existing users is set to 160 days due to the transitionary nature of the environment between NS2 and the customer. Compensating controls surrounding the network through AWS Security Groups and auditing capabilities local to the operating system ensure that access to the system is restricted and activity performed on the system are recorded. Given that users must VPN into the environment, credentials can be more easily and frequently rotated on the VPN server rather than the individual systems. For certain parts of the organization, centralized authentication is leveraged where the password are more easily applied.

Furthermore, some parts of the organization may choose to follow the guidance provided by NIST SP 800-63B Section 5.1.1.2 paragraph 9 which states that "Verifiers SHOULD NOT require memorized secrets to be changed arbitrarily (e.g., periodically). However, verifiers SHALL force a change if there is evidence of compromise of the authenticator." and simply not expire passwords in favor of longer and more complex passphrases which are rotated as needed.

### Multifactor Authentication via PAM

__Description__

RHEL 8 must implement smart card logon for multifactor authentication for access to interactive accounts. There are various methods of implementing multifactor authentication for RHEL 8. Some methods include a local system multifactor account mapping or joining the system to a domain and utilizing a Red Hat idM server or Microsoft Windows Active Directory server. Any of these methods will require that the client operating system handle the multifactor authentication correctly.

__Applicable STIGS__

RHEL-08-020250 - SV-230372r599732

__Justification__

Depending on where the system has been deployed, there may already be mitigating controls in place to handle multifactor authentication to restrict access to the environment where the system is being hosted.

### Temporary User Accounts - Emergency

__Description__

RHEL 8 emergency accounts must be automatically removed or disabled after the crisis is resolved or within 72 hours.

__Applicable STIGS__

RHEL-08-020270 - SV-230374r599732

__Justification__

Temporary user accounts are not included in the base image.

### Unnecessary User Accounts

__Description__

RHEL 8 must not have unnecessary accounts.

__Applicable STIGS__

RHEL-08-020320 - SV-230379r627750

__Justification__

Unnecessary user accounts are not included in the base image.

### Notification of Audit Volume Capacity

__Description__

The RHEL 8 System Administrator (SA) and Information System Security Officer (ISSO) (at a minimum) must be alerted when the audit storage volume is full.

__Applicable STIGS__

RHEL-08-030050 - SV-230391r599732

__Justification__

The setting `max_log_file_action` is set to `rotate` rather than `syslog` to ensure that the system continues to function. The audit partition is never resized as the root volume must remain consistent with existing standards.

Volumes and storage will be monitored different depending on where the base image is used within the organization. In some instances mitigating controls such as third party applications are pushed to the systems, e.g., aws cloudwatch agents or splunk forwarders, which collect and centralize logs across the filesystem which can also handle the alerting. In other instances, these systems are being deployed into a customer's environment and thus it is on the customer to configure centralized logging and subsequently the alerting.

### Audit Log Directory Permissions

__Description__

RHEL 8 audit log directories must have a mode of 0600 or less permissive to prevent unauthorized read access.

__Applicable STIGS__

RHEL-08-030120 - SV-230401r599732

__Defective Detection__

OpenSCAP

__Justification__

The `auditd` service does not function when permissions are set to `0600` on the `/var/log/audit` directory. The permissions must be set to `0700` in order for the `auditd` service to function. Case has been opened with Red Hat regarding this issue.

### Record Offloading to Remote System

__Description__

The RHEL 8 audit records must be off-loaded onto a different system or storage media from the system being audited.

__Applicable STIGS__

RHEL-08-030690 - SV-230479r599732

__Justification__

Depending on the purpose of the system, centralized logging may be configured differently throughout the organization. In some instances, third party applications are pushed to the systems, e.g., splunk forwarders, which collect and centralize logs across the filesystem.

### Secure Transmission of Offloaded Records

__Description__

RHEL 8 must encrypt the transfer of audit records off-loaded onto a different system or media from the system being audited.

__Applicable STIGS__

RHEL-08-030710 - SV-230481r599796
RHEL-08-030720 - SV-230482r599732

__Justification__

It is the responsibility of the customer to configure centralized logging. Once configured, it is again the responsibility of the customer to ensure that communication between the two systems is encrypted.

### Synchronize System Time with Redundant Time Source

__Description__

RHEL 8 must compare internal information system clocks at least every 24 hours with a server synchronized to an authoritative time source, such as the United States Naval Observatory (USNO) time servers, or a time server designated for the appropriate DoD network (NIPRNet/SIPRNet), and/or the Global Positioning System (GPS).

__Applicable STIGS__

RHEL-08-030740 - SV-230484r599732

__Justification__

Time is synchronized through chrony rather than ntp and is synchronized to the cloud provider's available time sync service. For systems deployed in Amazon Web Services (AWS), the Amazon Time Sync Service through the AWS API exposed to all EC2 instances is used. AWS leverages a fleet of redundant satellite-connected and atomic clocks in each region to deliver a highly accurate reference clock. For systems deployed in Azure, VMICTimeSync is used through Linux Integration Services which enables a Stratum-3 time source to be made available to each virtual machine.

### Disable Attached or Built-in Camera

__Description__

RHEL 8 must cover or disable the built-in or attached camera when not in use.

__Applicable STIGS__

RHEL-08-040020 - SV-230493r627750

__Justification__

The systems are deployed to cloud environment systems that do not have built-in cameras.

### Restricting Ports, Protocols, and/or Services According to The PPSM CLSA

__Description__

RHEL 8 must be configured to prohibit or restrict the use of functions, ports, protocols, and/or services, as defined in the Ports, Protocols, and Services Management (PPSM) Category Assignments List (CAL) and vulnerability assessments.

__Applicable STIGS__

RHEL-08-040030 - SV-230500r627750

__Justification__

This STIG requires manual review and cannot be automated.

### Default Host-based Firewall Configuration

__Description__

A RHEL 8 firewall must employ a deny-all, allow-by-exception policy for allowing connections to other systems.

__Applicable STIGS__

RHEL-08-040090 - SV-230504r599732

__Justification__

Configuration should be applied post-deployment as inclusion into the base image could cause provisioning issues. Automation exists to configure iptables in place of firewalld with application presets which include authorized ports and protocols.

### noexec /tmp mount option

__Description__

RHEL 8 must mount /tmp with the noexec option.

__Applicable STIGS__

RHEL-08-040125 - SV-230513r627750

__Justification__

The noexec mount option on the /tmp mount prevents the install of commonly used applications such as AWS CLI and SAPAPP/HANA.

### Application Whitelisting

__Description__

The RHEL 8 fapolicy module must be configured to employ a deny-all, permit-by-exception policy to allow the execution of authorized software programs.

__Applicable STIGS__

RHEL-08-040137 - SV-244546r743887

__Justification__

The fapolicy module is configured in monitor mode due to the disruptive nature of non-tuned whitelisting.

### Remove iprutils Package

__Description__

The iprutils package must not be installed unless mission essential on RHEL 8.

__Applicable STIGS__

RHEL-08-040380 - SV-230560r599732

__Justification__

The `iprutils` package is essential to the operation of various SAP software applications, such as HANA 2.0. Without this package, those SAP applications will not function.

### Remove tuned Package

__Description__

The tuned package must not be installed unless mission essential on RHEL 8.

__Applicable STIGS__

RHEL-08-040390 - SV-230561r599732

__Justification__

The `tuned` package is essential to the operation of various SAP software applications, such as HANA 2.0. Without this package, those SAP applications will not function.

### Kerberos Keytabs

__Description__

Remove all `*.keytabs` from `/etc`.

__Applicable STIGS__

RHEL-08-010161 - SV-230238r599732

__Justification__

Systems are often domain joined using sssd and realmd which rely on storage of key material within the /etc/krb5.keytab to maintain a trust relationship with Key Distribution Center (KDC) through a centralized identity provider (IDP). Removal of the file prevents users from being able to access the machine using their domain credentials.

### Temporary User Accounts - Expiration

__Description__

RHEL 8 must automatically expire temporary accounts within 72 hours.

__Applicable STIGS__

RHEL-08-020270 - SV-230374r903129

__Justification__

Temporary user accounts are not included in the base image.

### TEMPLATE

__Description__

TBD

__Applicable STIGS__

TBD

__Defective Detection__

TBD

__Justification__

TBD

## Backlog

The following STIGS must be closed as gaps:

* RHEL-08-010090 - Should obtain DOD certificates and close gap when possible.
