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
<h2>First step is to configure the provider block</h2>
<h2>Networking</h2>
<h3>subnet</h3>
<h3>private subnet</h3>
<h3>Internet Gateway</h3>
<h3>Routable</h3>
<h3>Route for public subnet</h3>
<h3>Association of public subnet and public route</h3>
<h3>Nat Gateway</h3>
<p>Note: To ensure proper ordering, it is recommended to add an explicit dependency on the Internet Gateway for the VPC.</p>
<h3>Routable for private subnet</h3>
<h3>Route for private subnet</h3>
<h3>Association of private route table to private subnet</h3>
<h3>Security Group</h3>
<h3>Private Security Group</h3>
<h3>Aws instance in public subnet</h3>
<h3>Run terraform init</h3>
 <p>terraform init: it initializes the terraform working directory, downloads the necessary provider plugins, and sets up the backend configuration.</p>
  <code>terraform init</code>
<h3>Run terraform plan</h3>
  <p>terraform plan: it helps you understand what changes will be made to your infrastructure before applying them</p>
  <code>terraform plan</code>
<h3>Run terraform apply</h3>
 <p>terraform apply: it applies the changes required to reach the desired state of your infrastructure as defined in your Terraform configuration files.</p>
   <code>terraform apply</code>
![Image](https://github.com/user-attachments/assets/1a0007a1-ed2e-40a6-ac4a-e4e92a833e38)
<p>this is what shows on the terminal affecting running the <code>terraform apply</code></p>
<h3>Time to get into the aws console to see the vpc created</h3>
<p>this image shows the vpc was successfully created</p>
![Image](https://github.com/user-attachments/assets/a5349671-1d27-44be-ad7d-6d7643155758)


