# moncash-backend
This repository contains the code for moncash-backend, an e-commerce backend that leverages the Moncash API, a payment service provided by Digicel in Haiti. This API endpoint is designed to receive payments from e-commerce websites built with React or Vue.js.

# Usage
To deploy the project using Terraform, follow these instructions:

## Prerequisites
1. **Terraform Installed**: Ensure that Terraform is installed on your machine. You can download and install Terraform from the [official website](https://www.terraform.io/downloads.html).

2. **AWS Credentials**: You need to have AWS credentials set up on your machine or environment. This includes access key ID and secret access key with appropriate permissions to deploy resources.

3. **Moncash API Credentials**: Obtain the necessary API credentials from Moncash to integrate with their service.

## Deployment Steps
1. **Clone the Repository**: Clone this repository to your local machine.

   ```bash
   git clone <repository_url>
   ```

2. **Navigate to the Project Directory**: Change directory to the project directory.

   ```bash
   cd <project_directory>
   ```

3. **Initialize Terraform**: Run `terraform init` to initialize the working directory containing Terraform configuration files.

   ```bash
   terraform init
   ```

4. **Review and Modify Configuration**: Review the Terraform configuration files (`*.tf`) to ensure they match your requirements. Modify any variables or settings as needed.

5. **Plan Deployment**: Run `terraform plan` to preview the changes that Terraform will make.

   ```bash
   terraform plan
   ```

6. **Apply Changes**: If the plan looks good, apply the changes by running `terraform apply`.

   ```bash
   terraform apply
   ```

7. **Confirm Deployment**: Confirm the deployment by typing `yes` when prompted. Terraform will begin provisioning the AWS resources according to your configuration.

8. **Verify Deployment**: Once Terraform completes the deployment, verify that the resources are created as expected. You can check the AWS Management Console or use AWS CLI commands to inspect the deployed resources.

## Updating Resources
If you need to update or modify the resources after deployment, make the necessary changes to the Terraform configuration files and reapply them using `terraform apply`.

```bash
terraform apply
```

## Destroying Resources
To tear down and destroy the resources created by Terraform, use the `terraform destroy` command.

```bash
terraform destroy
```

Confirm the destruction by typing `yes` when prompted.

This completes the deployment process using Terraform.
