# OpenStack Edge Agent Mode

This directory contains Terraform configurations for deploying an Ubuntu VM on OpenStack with cloud-init configuration for SSH access. This setup is designed for agent-mode deployment where you need a basic Ubuntu VM with proper SSH access.

## Prerequisites

- Terraform >= 1.0.0
- OpenStack credentials and access

## Authentication

### Using OpenStack RC File (Recommended)

1. Download your OpenStack RC file from the OpenStack dashboard:
   - Go to Project > Compute > Access & Security > API Access
   - Click "Download OpenStack RC File"
   - Save it in the `.rc` directory of this project

2. Source the RC file before running Terraform:
```bash
source .rc/your-openrc.sh
# You will be prompted for your OpenStack password
```

3. Verify the environment variables are set:
```bash
env | grep OS_
```

### Alternative: Using terraform.tfvars

If you prefer not to use the RC file, you can create a `terraform.tfvars` file with your OpenStack credentials:
```hcl
openstack_auth_url    = "your-auth-url"
openstack_username    = "your-username"
openstack_password    = "your-password"
openstack_tenant_name = "your-tenant"
openstack_region      = "your-region"
```

## VM Configuration

This Terraform configuration deploys an Ubuntu 22.04 VM with the following specifications:

- Uses an ephemeral volume (local disk)
- Configures SSH access with both password and key-based authentication
- Sets up a non-root user with sudo privileges
- Configures network with DHCP
- Enables SSH service on boot

## Cloud-Init Configuration

The cloud-init configuration is templated to keep sensitive information out of version control:

- User credentials are provided via terraform.tfvars (not committed to git)
- SSH keys can be imported from GitHub
- Password authentication is enabled for fallback access

## Usage

1. Create a `terraform.tfvars` file from the example:
```bash
cp terraform.tfvars.example terraform.tfvars
```

2. Edit the `terraform.tfvars` file to add your SSH key, password hash, and GitHub username.

3. Initialize Terraform:
```bash
terraform init
```

4. Plan your changes:
```bash
terraform plan
```

5. Apply the configuration:
```bash
terraform apply
```

6. Connect to your VM using SSH:
```bash
ssh ubuntu@<vm_ip_address>
```

## Provider Configuration

The OpenStack provider can be configured either through:
- OpenStack RC file (environment variables)
- The `terraform.tfvars` file
- Direct provider configuration in `main.tf`

## Security Note

Never commit sensitive information like passwords or tokens to version control. The following files are git-ignored by default:
- `terraform.tfvars`
- OpenStack RC files (`.rc/` directory)
- All files ending in `.rc` or `openrc.sh` 