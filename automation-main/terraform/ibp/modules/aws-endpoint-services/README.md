aws-endpoint-services Module
===================

This module creates a Network Load Balancer, Endpoint Service, and Endpoint on demand

The general concept is to share a TCP service with a disconnected VPC.  This is done by placing a network load balancer (NLB) in front of the instance providing the service. Once established, the NLB is made public in the AWS backend through an endpoint service.  Once the endpoint service is created, an endpoint is created in the disconnected VPC that consumes the endpoint service.  In this manner, the TCP service is now shared between disconnected VPCs.

Please refer to this article for more details:
https://aws.amazon.com/blogs/networking-and-content-delivery/how-to-securely-publish-internet-applications-at-scale-using-application-load-balancer-and-aws-privatelink/


Implementation of aws-instance Module
=====================================

Please see the README.md file underneath the `example_root` folder for correct implementation steps.

**DO NOT Run the terraform directly from this module folder**

Dependencies
------------

* Terraform 0.12
* AWS Administrator level privileges or privileges to manage VPC, EC2, EIPs and related services
* AWS S3 buckets to store the terraform state files
