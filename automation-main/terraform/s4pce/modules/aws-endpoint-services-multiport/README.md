# aws-endpoint-services module

This module creates a Network Load Balancer, Endpoint Service, and Endpoint on demand

The general concept is to share a TCP service with a disconnected VPC.  This is done by placing a network load balancer (NLB) in front of the instance providing the service. Once established, the NLB is made public in the AWS backend through an endpoint service.  Once the endpoint service is created, an endpoint is created in the disconnected VPC that consumes the endpoint service.  In this manner, the TCP service is now shared between disconnected VPCs.

Please refer to this article for more details:
https://aws.amazon.com/blogs/networking-and-content-delivery/how-to-securely-publish-internet-applications-at-scale-using-application-load-balancer-and-aws-privatelink/


## Dependencies
* See [tf-docs](./tf-docs.md) for terraform dependencies

## Example
* See [module-test](./example-root/module-test.tf) for examples
