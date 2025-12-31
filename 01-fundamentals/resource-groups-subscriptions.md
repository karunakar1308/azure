# Resource Groups and Subscriptions

## Azure Hierarchy

Understanding Azure's organizational structure is crucial for managing resources efficiently.

```
Management Groups
    └── Subscriptions
            └── Resource Groups
                    └── Resources (VMs, Storage, etc.)
```

## Subscriptions

### What is a Subscription?

A subscription is a logical container for your resources and serves as:
- **Billing boundary**: Each subscription gets its own bill
- **Access control boundary**: Manage access at subscription level
- **Resource quota boundary**: Limits apply per subscription

### Subscription Types

1. **Free Trial**: $200 credit for 30 days
2. **Pay-As-You-Go**: Most common, pay for what you use
3. **Enterprise Agreement (EA)**: For large organizations
4. **Student**: $100 credit for students
5. **Visual Studio**: Included with VS subscriptions
6. **CSP (Cloud Solution Provider)**: Through Microsoft partners

### Multiple Subscriptions Strategy

Organizations often use multiple subscriptions for:

**By Environment:**
- Development Subscription
- Testing Subscription
- Production Subscription

**By Department:**
- Marketing Subscription
- Engineering Subscription  
- Finance Subscription

**By Cost Center:**
- Project A Subscription
- Project B Subscription

**Benefits:**
- Separate billing
- Independent cost tracking
- Isolated permissions
- Separate resource limits

### Managing Subscriptions

#### List All Subscriptions

```bash
# Azure CLI
az account list --output table

# PowerShell
Get-AzSubscription
```

#### Switch Between Subscriptions

```bash
# Azure CLI
az account set --subscription "<subscription-name-or-id>"

# PowerShell
Set-AzContext -SubscriptionId "<subscription-id>"
```

#### View Current Subscription

```bash
# Azure CLI
az account show

# PowerShell
Get-AzContext
```

## Resource Groups

### What is a Resource Group?

A resource group is a logical container for Azure resources that share the same:
- **Lifecycle**: Deploy, update, and delete together
- **Location**: Metadata stored in one region (resources can be anywhere)
- **Permissions**: Apply RBAC at resource group level
- **Billing**: Track costs by resource group

### Key Characteristics

1. **Every resource must belong to one resource group**
2. **Resources can only belong to ONE resource group**
3. **Resource groups cannot be nested**
4. **Resources can be moved between resource groups**
5. **Resource groups can span regions**
6. **Deleting a resource group deletes all resources in it**

### Naming Conventions

Good naming helps organization and automation.

**Recommended Pattern:**
```
rg-<app-or-service>-<subscription-type>-<region>-<###>

Examples:
rg-webapp-prod-eastus-001
rg-database-dev-westeurope-001
rg-storage-test-centralus-001
```

**Components:**
- `rg-`: Prefix indicating resource group
- **App/Service**: Application or workload name
- **Environment**: prod, dev, test, staging
- **Region**: Primary region
- **Instance**: Sequential number for multiple instances

### Creating Resource Groups

#### Using Azure Portal

1. Navigate to **Resource groups**
2. Click **+ Create**
3. Fill in:
   - Subscription
   - Resource group name
   - Region
4. Add tags (optional)
5. Click **Review + create**

#### Using Azure CLI

```bash
# Basic creation
az group create \
  --name rg-webapp-prod-eastus-001 \
  --location eastus

# With tags
az group create \
  --name rg-webapp-prod-eastus-001 \
  --location eastus \
  --tags Environment=Production Project=WebApp CostCenter=Engineering
```

#### Using PowerShell

```powershell
# Basic creation
New-AzResourceGroup -Name "rg-webapp-prod-eastus-001" -Location "eastus"

# With tags
$tags = @{Environment="Production"; Project="WebApp"; CostCenter="Engineering"}
New-AzResourceGroup -Name "rg-webapp-prod-eastus-001" -Location "eastus" -Tag $tags
```

### Managing Resource Groups

#### List All Resource Groups

```bash
# Azure CLI
az group list --output table

# PowerShell
Get-AzResourceGroup | Format-Table
```

#### View Resource Group Details

```bash
# Azure CLI
az group show --name rg-webapp-prod-eastus-001

# PowerShell
Get-AzResourceGroup -Name "rg-webapp-prod-eastus-001"
```

#### List Resources in a Resource Group

```bash
# Azure CLI
az resource list --resource-group rg-webapp-prod-eastus-001 --output table

# PowerShell  
Get-AzResource -ResourceGroupName "rg-webapp-prod-eastus-001"
```

#### Update Resource Group (Tags)

```bash
# Azure CLI
az group update \
  --name rg-webapp-prod-eastus-001 \
  --set tags.Environment=Production tags.Owner=TeamA

# PowerShell
Set-AzResourceGroup -Name "rg-webapp-prod-eastus-001" -Tag @{Environment="Production"; Owner="TeamA"}
```

#### Delete Resource Group

⚠️ **Warning**: This deletes ALL resources in the group!

```bash
# Azure CLI (with confirmation)
az group delete --name rg-webapp-prod-eastus-001

# Azure CLI (skip confirmation)
az group delete --name rg-webapp-prod-eastus-001 --yes --no-wait

# PowerShell
Remove-AzResourceGroup -Name "rg-webapp-prod-eastus-001" -Force
```

## Tags

Tags are name-value pairs for organizing and tracking resources.

### Common Tag Strategies

#### Cost Management Tags
```json
{
  "CostCenter": "Engineering",
  "Project": "WebApp",
  "Owner": "john@company.com",
  "Budget": "10000"
}
```

#### Environment Tags
```json
{
  "Environment": "Production",
  "Criticality": "High",
  "MaintenanceWindow": "Sunday-2AM-6AM"
}
```

#### Compliance Tags
```json
{
  "DataClassification": "Confidential",
  "ComplianceRequirement": "HIPAA",
  "BackupRequired": "Yes"
}
```

### Applying Tags

#### At Resource Group Level

```bash
# Azure CLI
az group update \
  --name rg-webapp-prod \
  --tags Environment=Production CostCenter=IT
```

#### At Resource Level

```bash
# Tag a VM
az vm update \
  --resource-group rg-webapp-prod \
  --name myVM \
  --set tags.Environment=Production
```

#### Bulk Tag Application

```bash
# Tag all resources in a resource group
resources=$(az resource list --resource-group rg-webapp-prod --query "[].id" --output tsv)

for resource in $resources; do
  az resource tag --tags Environment=Production --ids $resource
done
```

### Querying by Tags

```bash
# Find all Production resources
az resource list --tag Environment=Production --output table

# Find resources with multiple tags
az resource list \
  --tag Environment=Production \
  --tag CostCenter=Engineering \
  --output table
```

## Best Practices

### Resource Group Organization

✅ **DO:**
- Group resources by lifecycle (create/delete together)
- Use consistent naming conventions
- Apply tags for cost tracking and organization
- Separate environments (dev, test, prod) into different resource groups
- Document your resource group strategy

❌ **DON'T:**
- Mix different lifecycles in same resource group
- Create resource groups without clear purpose
- Forget to apply RBAC permissions
- Ignore cost management tags

### Common Patterns

#### Pattern 1: By Application
```
rg-webapp-frontend-prod
rg-webapp-backend-prod
rg-webapp-database-prod
```

#### Pattern 2: By Tier
```
rg-prod-web
rg-prod-app
rg-prod-data
```

#### Pattern 3: By Environment
```
rg-myapp-dev
rg-myapp-test
rg-myapp-staging
rg-myapp-prod
```

### Subscription Limits

Be aware of Azure limits per subscription:

| Resource | Limit |
|----------|-------|
| Resource groups per subscription | 980 |
| Resources per resource group | 800 |
| Tags per resource/resource group | 50 |
| Virtual networks | 1,000 |
| Storage accounts | 250 |

*Limits vary by region and can be increased via support request*

## Security and Access Control

### RBAC (Role-Based Access Control)

Apply permissions at resource group level:

```bash
# Grant user Contributor access to resource group
az role assignment create \
  --role "Contributor" \
  --assignee user@company.com \
  --resource-group rg-webapp-prod

# Grant service principal Reader access
az role assignment create \
  --role "Reader" \
  --assignee <service-principal-id> \
  --resource-group rg-webapp-prod
```

### Common Built-in Roles

- **Owner**: Full access including access management
- **Contributor**: Full access except access management  
- **Reader**: View-only access
- **User Access Administrator**: Manage user access only

## Cost Management

### Set Budget on Resource Group

1. Navigate to **Cost Management + Billing**
2. Select **Budgets**
3. Click **+ Add**
4. Set scope to resource group
5. Configure budget amount and alerts

### View Costs by Resource Group

```bash
# Azure CLI
az consumption usage list \
  --start-date 2025-01-01 \
  --end-date 2025-01-31 \
  --query "[?instanceLocation=='rg-webapp-prod']" \
  --output table
```

## Moving Resources

### Move Resources Between Resource Groups

```bash
# Get resource ID
resourceId=$(az resource show \
  --resource-group source-rg \
  --name myVM \
  --resource-type Microsoft.Compute/virtualMachines \
  --query id --output tsv)

# Move resource
az resource move \
  --destination-group target-rg \
  --ids $resourceId
```

### Move Limitations

- Some resources cannot be moved (check documentation)
- Downtime may occur during move
- Resource IDs change after move
- RBAC assignments don't move automatically

## Practical Examples

### Create Complete Environment

```bash
#!/bin/bash

# Variables
APP_NAME="mywebapp"
ENVIRONMENT="prod"
LOCATION="eastus"

# Create resource groups
az group create --name "rg-${APP_NAME}-web-${ENVIRONMENT}" --location "$LOCATION"
az group create --name "rg-${APP_NAME}-data-${ENVIRONMENT}" --location "$LOCATION"
az group create --name "rg-${APP_NAME}-shared-${ENVIRONMENT}" --location "$LOCATION"

# Apply tags
for rg in "rg-${APP_NAME}-web-${ENVIRONMENT}" "rg-${APP_NAME}-data-${ENVIRONMENT}" "rg-${APP_NAME}-shared-${ENVIRONMENT}"; do
  az group update --name "$rg" \
    --tags Environment="${ENVIRONMENT}" \
           Application="${APP_NAME}" \
           ManagedBy="DevOps" \
           CostCenter="Engineering"
done
```

## Next Steps

- [Azure Regions and Availability Zones](regions-availability-zones.md)
- [Azure Portal Navigation](azure-portal-navigation.md)
- [Azure Virtual Machines](../02-core-compute/azure-virtual-machines.md)

---

**Key Takeaways:**
- Subscriptions are billing and administrative boundaries
- Resource groups organize resources by lifecycle
- Use tags for cost tracking and organization
- Apply RBAC at resource group level for security
- Follow naming conventions for consistency
