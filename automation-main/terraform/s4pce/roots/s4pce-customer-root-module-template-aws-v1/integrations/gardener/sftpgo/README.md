# integrations/gardener/sftpgo

[[_TOC_]]

## Introduction

This SFTP integration relies on SFTPGo, an event-driven file transfer solution.

This integration module will add an RDS instance and S3 bucket for use with SFTPGo.

The SFTPGo application is hosted on a Gardener shoot cluster, which will consume some of the output values from this integration during its pre-deployment configuration.

## Prerequisites

> **IMPORTANT**: If there is no Gardener shoot cluster configured and available in the region which this customer is deployed to, this solution **will not work**.

* Management infrastructure deployed
* Customer root layers `00`, `01` and `02` deployed
* Customer `s4-management` or `dev-management` integration layer `00` deployed
  * `dev-` vs `s4-` depends on the deployment environment
  * Access to the Customer VPC from the Management VPC is **required for storage gateway activation**

## Overview

High-level overview of deployed resources:

* **RDS Instance** for use as a database backend for SFTPGo
  * This is deployed to the region's Gardener Shoot VPC in a dedicated subnet group
  * This instance is NOT to be shared with other customers
* **S3 File Gateway** for handling file transfers; used by SFTPGo and SAP applications
  * A S3 bucket is created solely for use by this solution
  * The S3 bucket will be deployed in the same region as the rest of the customer's infrastructure

## Authors

Nick Martinez (nick.martinez@sap.com)
