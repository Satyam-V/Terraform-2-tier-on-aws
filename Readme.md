<!-- Deploy Two Tier Architecture in AWS using Terraform -->
In this article, we are going to cover Deploy Two Tier Architecture in AWS using Terraform.

We will introduce Terraform, an infrastructure-as-code tool, and demonstrate its use to deploy a two-tier architecture in AWS. 
To run the complete code You Have to perform these steps manually as according to your requirements:
### 🔐 ACM certificate
Go to AWS console --> AWS Certificate Manager (ACM) and make sure you have a valid certificate in Issued status, if not , feel free to create one and use the domain name on which you are planning to host your application.

### 👨‍💻 Route 53 Hosted Zone
Go to AWS Console --> Route53 --> Hosted Zones and ensure you have a public hosted zone available, if not create one.
### 🔐 Key-Pair
Generate a key pair under instances and store it in key folder under modules.