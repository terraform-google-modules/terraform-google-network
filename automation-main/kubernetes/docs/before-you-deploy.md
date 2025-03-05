# Before you Deploy

Before proceeding with the deployment, ensure the following prerequisites are met:

Note: The required architecture is 1 Gardener cluster PER customer. At this time customers are not able to share clusters. For example; If one customer has the SFTPGo solution and another customer has also purchased it a new Shoot VPC would need to be used for that new customer. 

## Table of Contents
[TOC]
### **Gardener Project**:
You must have access to a Gardener project where the Kubernetes cluster will be deployed. Contact your regional Gardener team to have them create you a new project.
<br>
<br>

### **AWS Environment**:
An AWS account is required as the infrastructure provider. Ensure you have the necessary permissions to create and manage resources and quotas. Based on AWS default quotas and the requirements of a Gardener cluster, you may need to request increases for specific quotas, especially if your default quota is already mostly consumed. Key resources to review include:

- **NAT Gateways**: Gardener clusters, depending on their configuration, may require multiple NAT gateways, especially if you are deploying into multiple availability zones for high availability. AWS accounts have a default limit on the number of NAT gateways per region.

- **Elastic IP Addresses (EIPs)**: Each NAT gateway requires an Elastic IP address, and there's a default limit on the number of EIPs per region. Ensure you have enough EIPs available for the NAT gateways and any other services that require a static IP address.

- **RDS Instances**: If deploying multiple RDS instances for various environments (development, staging, production), ensure your account's RDS instance limit supports the required number of databases.

It's advisable to review your current usage and the AWS Service Quotas console to request quota increases well in advance of your deployment. This process can take some time, depending on the resources and the region.
<br>
<br>

### **Request New VPC Cidr Ranges**:
Request new VPC CIDR ranges from your network team. This is required to create a new VPC for the Kubernetes cluster. Ensure the CIDR range does not overlap with any existing VPCs in your account. Recommended CIDR ranges size is `/19` and `/20`.
<br>
<br>

### **Configured VPC and RDS PostgreSQL Database**:
The deployment requires a Virtual Private Cloud (VPC) and an RDS PostgreSQL database. These should be created and configured using Terraform to ensure infrastructure as code practices are followed.
<br>
<br>

### **Public Route53 Hosted Zone**:
A public hosted zone in AWS Route53 is required for managing the DNS records of the services deployed in the Kubernetes cluster.

Recommendation is for a new hosted zone dedicated for PCE Gardener and Kubernetes usage. 
<br>
<br>

### **Vault Path and AppRole Token**:
For secret management, a path in HashiCorp Vault is needed along with an AppRole token. This ensures that secrets and credentials are stored securely and accessed in a controlled manner.
<br>
<br>

### **Dedicated GitLab Project**:
A dedicated GitLab project for PCE Gardener use is required for storing the deployment files and configurations. This project should be created with users having the necessary permissions to configure CI/CD settings, and generating access tokens for the deployment scripts be able to run autated pipeline jobs.
<br>
<br>

### **Optional Dedicated IAS Tenant**:
For easier management of operator users, a dedicated Identity Authentication Service (IAS) tenant can be used. This is optional but recommended for managing access and authentication in a more granular manner.
<br>
<br>

### Once all the prerequisites are in place, you are ready to proceed with the [deployment](deployment-steps.md).