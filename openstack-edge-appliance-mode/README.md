# OpenStack Edge Appliance Mode

This directory contains Terraform configurations for deploying OpenStack resources in Edge Appliance Mode. This setup is designed for Palette edge appliance deployments where you need to provision infrastructure for Spectro Cloud's edge management.

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

## Edge Appliance Configuration

This Terraform configuration is designed for Spectro Cloud Palette Edge deployments and includes:

- VM provisioning for edge appliance mode
- Integration with Palette's edge infrastructure
- Secure token handling for edge host registration
- Network configuration for edge connectivity

## User Data Configuration

The deployment uses a templated user-data file that:

- Configures the edge appliance to connect to Palette
- Sets up necessary tags and identifiers
- Handles edge host registration securely
- Keeps sensitive tokens out of version control

## Usage

1. Create a `user-data` file from the template:
```bash
cp user-data.template user-data
```

2. Edit the `user-data` file to add your edge host token:
```yaml
edgeHostToken: YOUR_EDGE_HOST_TOKEN_HERE
```

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

6. Monitor the edge registration in the Palette console

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