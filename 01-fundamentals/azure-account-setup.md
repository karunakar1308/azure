# Azure Account Setup

## Creating Your Azure Account

### Free Azure Account

Microsoft offers a generous free tier for new users:

**What You Get:**
- **$200 credit** for the first 30 days
- **12 months** of popular free services
- **Always free** services (25+ services)

**Popular Free Services for 12 Months:**
- 750 hours of B1S Windows/Linux Virtual Machine
- 5 GB Blob Storage
- 250 GB SQL Database
- 1 million Azure Function requests

**Always Free Services:**
- Azure App Service (10 web apps)
- Azure Functions (1 million requests/month)
- Azure Cosmos DB (25 GB storage)
- Azure DevOps (5 users)
- Azure Active Directory (50,000 objects)

### Prerequisites

- Valid email address (Microsoft, Gmail, or corporate)
- Phone number for verification
- Credit card (for identity verification, won't be charged unless you upgrade)

### Step-by-Step Account Creation

#### Step 1: Navigate to Azure Portal
1. Go to [azure.microsoft.com/free](https://azure.microsoft.com/free)
2. Click **"Start free"** button

#### Step 2: Sign In or Create Microsoft Account
- If you have a Microsoft account (Outlook, Hotmail, etc.), sign in
- If not, click **"Create one"** to create a new Microsoft account

#### Step 3: Fill Out Your Information
1. **About you:**
   - Country/Region
   - First name
   - Last name
   - Email address
   - Phone number

2. **Identity verification by phone:**
   - Enter phone number
   - Receive and enter verification code

3. **Identity verification by card:**
   - Enter credit/debit card details
   - Note: You won't be charged unless you explicitly upgrade

4. **Agreement:**
   - Review subscription agreement
   - Check the agreement box
   - Click **"Sign up"**

#### Step 4: Setup Complete
- You'll be redirected to Azure Portal
- Your subscription is now active

## Understanding Your Subscription

### Subscription Types

#### 1. Free Trial
- $200 credit for 30 days
- Access to most Azure services
- Automatically converts to Pay-As-You-Go after 30 days (only if you upgrade)

#### 2. Pay-As-You-Go
- Pay only for what you use
- No upfront commitment
- Can set spending limits

#### 3. Enterprise Agreement (EA)
- For large organizations
- Volume licensing
- Committed spend discounts

#### 4. Student Account
- $100 credit (no credit card required)
- 12 months of free services
- Requires educational email (.edu)

### Billing and Cost Management

#### Setting Up Budget Alerts

1. In Azure Portal, search for **"Cost Management + Billing"**
2. Select **Budgets**
3. Click **+ Add**
4. Configure:
   - Budget name
   - Amount (e.g., $50/month)
   - Alert conditions (e.g., 80%, 90%, 100%)
   - Email recipients

#### Viewing Your Bill

1. Navigate to **Cost Management + Billing**
2. Select **Invoices**
3. View/download invoices

#### Cost Analysis

- View spending by service
- Forecast future costs
- Identify cost-saving opportunities

```bash
# Using Azure CLI to view cost
az consumption usage list --output table
```

## Azure Portal Overview

### Accessing Azure Portal

**URL:** [portal.azure.com](https://portal.azure.com)

### Key Portal Sections

1. **Home**: Dashboard with quick links
2. **All services**: Complete list of Azure services
3. **Resource groups**: Organize and manage related resources
4. **All resources**: View all created resources
5. **Subscriptions**: Manage subscriptions and billing

### Portal Navigation Tips

- Use **search bar** at top to quickly find services
- **Pin** frequently used services to dashboard
- Use **Cloud Shell** for CLI access (PowerShell or Bash)
- **Customize dashboard** for your workflow

## Installing Azure CLI

### Windows

```powershell
# Using MSI Installer
# Download from: https://aka.ms/installazurecliwindows
# Or use PowerShell:
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi
Start-Process msiexec.exe -ArgumentList '/I AzureCLI.msi /quiet'
```

### macOS

```bash
# Using Homebrew
brew update && brew install azure-cli
```

### Linux (Ubuntu/Debian)

```bash
# Install using apt
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

### Verify Installation

```bash
az --version
```

## Logging In via CLI

### Interactive Login

```bash
# Opens browser for authentication
az login
```

### Service Principal Login (for automation)

```bash
az login --service-principal \
  --username <app-id> \
  --password <password-or-cert> \
  --tenant <tenant-id>
```

### Setting Default Subscription

```bash
# List subscriptions
az account list --output table

# Set default subscription
az account set --subscription "<subscription-name-or-id>"

# Verify current subscription
az account show
```

## Installing Azure PowerShell

### Install Az PowerShell Module

```powershell
# Install for current user
Install-Module -Name Az -Repository PSGallery -Force -AllowClobber

# Verify installation
Get-InstalledModule -Name Az
```

### Connect to Azure

```powershell
# Interactive login
Connect-AzAccount

# Select subscription
Set-AzContext -SubscriptionId "<subscription-id>"
```

## Security Best Practices

### Enable Multi-Factor Authentication (MFA)

1. Go to Azure Active Directory
2. Select **Users**
3. Click **Per-user MFA**
4. Select your user and **Enable**

### Create Resource Groups Strategically

```bash
# Create resource group
az group create \
  --name myResourceGroup \
  --location eastus
```

**Best Practices:**
- Use separate resource groups for different environments (dev, test, prod)
- Apply tags for organization and cost tracking
- Set RBAC permissions at resource group level

### Use Azure Key Vault for Secrets

Never store sensitive information in code or configuration files.

```bash
# Create Key Vault
az keyvault create \
  --name myKeyVault \
  --resource-group myResourceGroup \
  --location eastus

# Store secret
az keyvault secret set \
  --vault-name myKeyVault \
  --name "DatabasePassword" \
  --value "SuperSecretPassword123!"
```

## Common Initial Setup Tasks

### 1. Create Your First Resource Group

```bash
az group create --name rg-learning --location eastus
```

### 2. Set Up Tags for Cost Tracking

```bash
az group update \
  --name rg-learning \
  --set tags.Environment=Development tags.Project=Learning
```

### 3. Configure Cloud Shell

1. Click Cloud Shell icon in portal (top right)
2. Choose Bash or PowerShell
3. Create storage account (first time only)

### 4. Install Visual Studio Code Azure Extension

- Open VS Code
- Install **Azure Account** extension
- Install **Azure Resources** extension
- Sign in to Azure from VS Code

## Troubleshooting Common Issues

### Issue: Credit Card Verification Fails
**Solution:**
- Ensure card is internationally enabled
- Try a different card
- Contact your bank
- Use virtual credit card if available

### Issue: Can't Create Certain Resources
**Solution:**
- Check if service is available in your region
- Verify subscription quotas
- Ensure you have required permissions

### Issue: Unexpected Charges
**Solution:**
- Review Cost Analysis in Cost Management
- Check for running VMs or other resources
- Set up budget alerts
- Delete unused resources

## Resource Cleanup

### Delete Resource Group (deletes all resources within)

```bash
az group delete --name myResourceGroup --yes --no-wait
```

### Stop VM Without Deleting

```bash
az vm deallocate --resource-group myResourceGroup --name myVM
```

## Next Steps

- [Azure Portal Navigation](azure-portal-navigation.md)
- [Resource Groups and Subscriptions](resource-groups-subscriptions.md)
- [Azure Regions and Availability Zones](regions-availability-zones.md)

## Quick Reference Commands

```bash
# Login
az login

# List subscriptions
az account list --output table

# Set subscription
az account set --subscription "<name-or-id>"

# List resource groups
az group list --output table

# List all resources
az resource list --output table

# Get current costs
az consumption usage list --output table
```

---

**Additional Resources:**
- [Azure Free Account FAQ](https://azure.microsoft.com/free/free-account-faq/)
- [Azure CLI Documentation](https://docs.microsoft.com/cli/azure/)
- [Azure PowerShell Documentation](https://docs.microsoft.com/powershell/azure/)
