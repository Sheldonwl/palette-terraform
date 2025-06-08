# OpenStack Terraform Configuration

This directory contains Terraform configurations for managing OpenStack resources.

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

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Plan your changes:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply
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