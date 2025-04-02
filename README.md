<h1>Automated AWS VPC Deployment with Terraform</h1>
<h2>Language used: Terraform</h2>
<h2>Introduction to project</h2>
<p>In today’s cloud-centric environment, efficient and secure network architecture is essential for deploying applications. This project focuses on configuring an Amazon Web Services (AWS) Virtual Private Cloud (VPC) using Terraform, an open-source infrastructure as code (IaC) tool. By automating the setup of a VPC, we can ensure a scalable and flexible network environment while minimizing manual errors and reducing deployment times.</p>
<h2>Prerequisites</h2>
<p>Before starting this project, ensure you have the following:
AWS Account: An active AWS account with the necessary permissions to create VPC resources.
Terraform Installed: Install Terraform on your local machine.
Basic Knowledge of AWS: Familiarity with AWS services, particularly VPC, subnets, route tables, and security groups.
Text Editor: VS Code</p>
<h2>Use Cases</h2>
<p>Configuring an AWS VPC with Terraform can serve various purposes, including:
<li>Isolated Network Environment: Creating a secure and isolated network for deploying applications, ensuring that resources are protected from unwanted access.</li>
<li>Multi-Tier Applications: Designing a multi-tier architecture (web, application, database layers) where different subnets can host different application tiers.</li>
<li>Disaster Recovery: Setting up a secondary VPC in a different region for disaster recovery, ensuring business continuity.</li>
<li>Hybrid Cloud Solutions: Integrating on-premises infrastructure with AWS by creating a VPC that connects to your data center via a VPN or Direct Connect.</li>
<l1>Testing and Development: Quickly spinning up and tearing down VPCs for development and testing purposes without manual configuration.</l1></p>
 <p>terraform init: it initializes the terraform working directory, downloads the necessary provider plugins, and sets up the backend configuration.</p>
 <p>terraform plan: it helps you understand what changes will be made to your infrastructure before applying them</p>
 <p>terraform apply: it applies the changes required to reach the desired state of your infrastructure as defined in your Terraform configuration files.</p>
 <h2>Please refer to the main.tf files attached to see the codes used for the deployment</h2>


