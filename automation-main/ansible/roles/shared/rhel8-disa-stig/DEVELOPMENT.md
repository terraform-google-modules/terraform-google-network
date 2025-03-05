# DISA STIG Development Guide for Red Hat Enterprise Linux (RHEL) 8

## Purpose

This documents the process on how this Ansible role was developed and the process that was used to validate the compliance of the target system.

This process was adapted from this guide:
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/security_hardening/scanning-the-system-for-security-compliance-and-vulnerabilities_security-hardening

Additional tasks have been added to the stig with the tag SAPNS2. Each task's name matches the individual test name in the ssg-rhel8-ds-1.2.xml profile.

## TODO
These are items that are still under development.

* TODO: configure/validate auditd against other golden image OSes
* TODO: configure sssd once domain join can be tested
* TODO: add epel tasks to clamav once local s3 bucket is available
* TODO: investigate non-breaking non-indempotent grub2-editenv (currently adds dupes in 'grub2-editenv - list')

## Prerequisites
Instantiate your RHEL8 instance for testing. Note that openscap may run out of memory with a .micro sized instance. In this example, I used:
```
AMI id: RHEL-8.0.0_HVM-20190426-x86_64-1-Hourly2-GP2
AMI owner: 219670896067
AMI size: t3.small
```

Execute these commands as root to add epel, the openscap scanner, and update all packages to latest in preparation for the scan:
```
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm --assumeyes && \
dnf install openscap-scanner scap-security-guide python3 wget --skip-broken --assumeyes && \
alternatives --set python /usr/bin/python3 && \
dnf update -y && \
reboot
```

Once complete, ```reboot``` the instance and proceed to the hardening step.

## Harden the instance
Execute this role with the ```redhat-harden.html``` playbook. For example:

```ansible-playbook -u ec2-user -i INSTANCE-IP, redhat-harden.yml```

Once completed, ```reboot``` the instance once again.

## Execute the oscap scan on the instance

Currently, there is no DISA profile. This role was instead developed against the PCI-DSS v3.2.1 baseline:
```
Document type: Source Data Stream
Imported: 2019-09-02T10:09:11

Stream: scap_org.open-scap_datastream_from_xccdf_ssg-rhel8-xccdf-1.2.xml
Generated: (null)
Version: 1.2
Profile
	Title: PCI-DSS v3.2.1 Control Baseline for Red Hat Enterprise Linux 8
	Id: xccdf_org.ssgproject.content_profile_pci-dss

	Description: Ensures PCI-DSS v3.2.1 security configuration settings are applied.
```

On the instance, generate the report:
```
sudo oscap xccdf eval --fetch-remote-resources --report report.html --profile ospp /usr/share/xml/scap/ssg/content/ssg-rhel8-ds-1.2.xml
```

## Test status

The current oscap profile ssg-rhel8-ds-1.2 test stands at: 86.041672%

not accounting for known positives below. The biggest improvements will come from a properly partitioned OS and various tweaks we can perform once we have a golden image.

## Known issues, false positives, and workarounds with the the ssg-rhel8-ds-1.2 profile. Need to be re-evaludated once the official DoD STIG profile is released

### RHEL8 changes to grub

RHEL8 depreciates the /etc/default/grub and editing the conf directly in favor of ```grubby``` and ```grub2-editenv```. The hardening uses thsese two commands to properly edit arguments but scanners will probably be looking for entries in /etc/default/grub. I backported a few to try and prevent this.

The way you generate the grub BLS configuration has also changed. running ```grub2-mkconfig``` is now potentially system breaking as it doesn't include kernel arguments specified by ```grubby``` and ```grub2-editenv```.

More info at these links:
https://access.redhat.com/solutions/3710121
https://access.redhat.com/solutions/3766391
https://wiki.centos.org/HowTos/Grub2


### Configure System Cryptography Policy

As part of FIPS, it's examining file ```/etc/crypto-policies/back-ends/openssl.config``` and correctly determines it's a symlink. However, it only accepts the regex ```^/etc/crypto-policies/local\.d/openssl-.*\.config$```, basically /etc/crypto-policies/local.d/* for acceptable paths of the source file. In RHEL8, this file lives in ```/usr/share/crypto-policies/FIPS/openssl.txt``` as configured by the ```/usr/bin/fips-mode-setup --enable``` command.

### Harden SSHD Crypto Policy

The profile is expecting and looks for a specific hard-coded scring in ```/etc/crypto-policies/back-ends/opensshserver.config``` of:

```
CRYPTO_POLICY='-oCiphers=aes128-ctr,aes256-ctr,aes128-cbc,aes256-cbc -oMACs=hmac-sha2-256,hmac-sha2-512 -oGSSAPIKeyExchange=no -oKexAlgorithms=diffie-hellman-group14-sha1,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521 -oHostKeyAlgorithms=rsa-sha2-256,ecdsa-sha2-nistp256,ecdsa-sha2-nistp256-cert-v01@openssh.com,ecdsa-sha2-nistp384,ecdsa-sha2-nistp384-cert-v01@openssh.com,rsa-sha2-512,ecdsa-sha2-nistp521,ecdsa-sha2-nistp521-cert-v01@openssh.com -oPubkeyAcceptedKeyTypes=ssh-rsa,ecdsa-sha2-nistp256,ecdsa-sha2-nistp384'
```

However, RHEL8 ships with the additinoally restrictive string:

```
CRYPTO_POLICY='-oCiphers=aes256-gcm@openssh.com,aes256-ctr,aes256-cbc,aes128-gcm@openssh.com,aes128-ctr,aes128-cbc -oMACs=hmac-sha2-256-etm@openssh.com,hmac-sha1-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha2-256,hmac-sha1,hmac-sha2-512 -oGSSAPIKeyExchange=no -oKexAlgorithms=ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512 -oHostKeyAlgorithms=rsa-sha2-256,rsa-sha2-256-cert-v01@openssh.com,ecdsa-sha2-nistp256,ecdsa-sha2-nistp256-cert-v01@openssh.com,ecdsa-sha2-nistp384,ecdsa-sha2-nistp384-cert-v01@openssh.com,rsa-sha2-512,rsa-sha2-512-cert-v01@openssh.com,ecdsa-sha2-nistp521,ecdsa-sha2-nistp521-cert-v01@openssh.com -oPubkeyAcceptedKeyTypes=rsa-sha2-256,rsa-sha2-256-cert-v01@openssh.com,ecdsa-sha2-nistp256,ecdsa-sha2-nistp256-cert-v01@openssh.com,ecdsa-sha2-nistp384,ecdsa-sha2-nistp384-cert-v01@openssh.com,rsa-sha2-512,rsa-sha2-512-cert-v01@openssh.com,ecdsa-sha2-nistp521,ecdsa-sha2-nistp521-cert-v01@openssh.com -oCASignatureAlgorithms=rsa-sha2-256,ecdsa-sha2-nistp256,ecdsa-sha2-nistp384,rsa-sha2-512,ecdsa-sha2-nistp521'
```

as configured by the ```/usr/bin/fips-mode-setup --enable``` command.

### Harden SSH client Crypto Policy

The profile is expecting a file /etc/ssh/ssh_config.d/02-ospp.conf with the following contents:

```
Match final all
RekeyLimit 512M 1h
GSSAPIAuthentication no
Ciphers aes256-ctr,aes256-cbc,aes128-ctr,aes128-cbc
PubkeyAcceptedKeyTypes ssh-rsa,ecdsa-sha2-nistp384,ecdsa-sha2-nistp256
MACs hmac-sha2-512,hmac-sha2-256
KexAlgorithms ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group14-sha1
```

However, RHEL8 ships with the crypto policy ```/etc/crypto-policies/back-ends/openssh.config```

```
Match final all
	Ciphers aes256-gcm@openssh.com,aes256-ctr,aes256-cbc,aes128-gcm@openssh.com,aes128-ctr,aes128-cbc
	MACs hmac-sha2-256-etm@openssh.com,hmac-sha1-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha2-256,hmac-sha1,hmac-sha2-512
	GSSAPIKeyExchange no
	KexAlgorithms ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512
	PubkeyAcceptedKeyTypes rsa-sha2-256,rsa-sha2-256-cert-v01@openssh.com,ecdsa-sha2-nistp256,ecdsa-sha2-nistp256-cert-v01@openssh.com,ecdsa-sha2-nistp384,ecdsa-sha2-nistp384-cert-v01@openssh.com,rsa-sha2-512,rsa-sha2-512-cert-v01@openssh.com,ecdsa-sha2-nistp521,ecdsa-sha2-nistp521-cert-v01@openssh.com
	CASignatureAlgorithms rsa-sha2-256,ecdsa-sha2-nistp256,ecdsa-sha2-nistp384,rsa-sha2-512,ecdsa-sha2-nistp521
```

as configured by the ```/usr/bin/fips-mode-setup --enable``` command.
