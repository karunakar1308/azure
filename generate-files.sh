#!/bin/bash

# Azure Learning Repository - File Generator Script
# Generates all remaining 34 documentation files
# 
# Usage: chmod +x generate-files.sh && ./generate-files.sh

echo "🚀 Azure Learning Repository - File Generator"
echo "=========================================="
echo ""
echo "This script will create 34 remaining files with structured content."
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

count=0

# Create file function
create_file() {
    local file="$1"
    local content="$2"
    
    # Create directory if needed
    mkdir -p "$(dirname "$file")"
    
    # Write content
    echo "$content" > "$file"
    
    echo -e "${GREEN}✓${NC} Created: $file"
    ((count++))
}

echo -e "${BLUE}📁 Creating folders...${NC}"
mkdir -p 02-core-compute 03-networking 04-storage 05-databases 06-identity-security 07-azure-devops 08-devops-dependencies 09-advanced
echo ""

# Due to GitHub's web interface limitations, this script contains templates.
# For the COMPLETE detailed script with all 34 files, please:
# 1. Clone this repository locally
# 2. Run this script to generate file structure
# 3. Each file contains a structured template you can expand

echo -e "${YELLOW}NOTE: Creating structured templates for all 34 files...${NC}"
echo ""

# Template function for consistent file structure
generate_template() {
    local service_name="$1"
    local category="$2"
    
    cat << EOF
# $service_name

## Overview
Brief description of $service_name and its purpose in Azure.

## Key Features
- Feature 1: Description
- Feature 2: Description
- Feature 3: Description
- Integration with Azure DevOps
- Scalability and performance

## Getting Started

### Prerequisites
- Azure subscription
- Azure CLI installed
- Basic understanding of $category

### Quick Setup

\`\`\`bash
# Example Azure CLI command
az [service] create \\
  --resource-group myRG \\
  --name my$(echo $service_name | tr ' ' '-' | tr '[:upper:]' '[:lower:]') \\
  --location eastus
\`\`\`

## Common Operations

### Create Resource
\`\`\`bash
# Creation command
\`\`\`

### Configure Resource
\`\`\`bash
# Configuration commands
\`\`\`

### Monitor Resource
\`\`\`bash
# Monitoring commands
\`\`\`

## Azure DevOps Integration

How this service integrates with Azure DevOps pipelines:

\`\`\`yaml
# Example pipeline task
- task: [ServiceTask]@1
  inputs:
    azureSubscription: 'connection'
    [service-specific-inputs]
\`\`\`

## Best Practices

✅ **DO:**
- Best practice 1
- Best practice 2
- Best practice 3
- Use for DevOps scenarios

❌ **DON'T:**
- Anti-pattern 1
- Anti-pattern 2
- Common mistake

## Pricing Considerations

- Pricing tier information
- Cost optimization tips
- Free tier availability

## Common Use Cases

1. **Use Case 1**: Description
2. **Use Case 2**: Description
3. **DevOps Scenario**: How it's used in CI/CD

## Troubleshooting

### Issue 1
**Problem**: Description
**Solution**: Resolution steps

### Issue 2
**Problem**: Description  
**Solution**: Resolution steps

## Next Steps

- Related service 1
- Related service 2
- [Azure DevOps Integration](../07-azure-devops/)

## Additional Resources

- [Official Documentation](https://docs.microsoft.com/azure/)
- [Pricing Calculator](https://azure.microsoft.com/pricing/calculator/)
- [Best Practices Guide](https://docs.microsoft.com/azure/architecture/)

EOF
}

echo -e "${BLUE}📂 02-CORE-COMPUTE (4 files)...${NC}"

create_file "02-core-compute/azure-app-service.md" "$(generate_template 'Azure App Service' 'web applications')"
create_file "02-core-compute/azure-kubernetes-service.md" "$(generate_template 'Azure Kubernetes Service (AKS)' 'container orchestration')"
create_file "02-core-compute/azure-functions.md" "$(generate_template 'Azure Functions' 'serverless computing')"
create_file "02-core-compute/azure-container-instances.md" "$(generate_template 'Azure Container Instances' 'containers')"

echo -e "${BLUE}📂 03-NETWORKING (5 files)...${NC}"

create_file "03-networking/azure-virtual-networks.md" "$(generate_template 'Azure Virtual Networks' 'networking')"
create_file "03-networking/network-security-groups.md" "$(generate_template 'Network Security Groups' 'network security')"
create_file "03-networking/azure-load-balancer.md" "$(generate_template 'Azure Load Balancer' 'load balancing')"
create_file "03-networking/application-gateway.md" "$(generate_template 'Application Gateway' 'application delivery')"
create_file "03-networking/vpn-expressroute.md" "$(generate_template 'VPN and ExpressRoute' 'hybrid connectivity')"

echo -e "${BLUE}📂 04-STORAGE (4 files)...${NC}"

create_file "04-storage/azure-blob-storage.md" "$(generate_template 'Azure Blob Storage' 'object storage')"
create_file "04-storage/azure-files.md" "$(generate_template 'Azure Files' 'file shares')"
create_file "04-storage/azure-disk-storage.md" "$(generate_template 'Azure Disk Storage' 'block storage')"
create_file "04-storage/storage-accounts.md" "$(generate_template 'Storage Accounts' 'storage management')"

echo -e "${BLUE}📂 05-DATABASES (4 files)...${NC}"

create_file "05-databases/azure-sql-database.md" "$(generate_template 'Azure SQL Database' 'relational databases')"
create_file "05-databases/azure-cosmos-db.md" "$(generate_template 'Azure Cosmos DB' 'NoSQL databases')"
create_file "05-databases/azure-postgresql-mysql.md" "$(generate_template 'Azure Database for PostgreSQL/MySQL' 'open-source databases')"
create_file "05-databases/azure-redis-cache.md" "$(generate_template 'Azure Cache for Redis' 'caching')"

echo -e "${BLUE}📂 06-IDENTITY-SECURITY (5 files)...${NC}"

create_file "06-identity-security/azure-active-directory.md" "$(generate_template 'Azure Active Directory' 'identity management')"
create_file "06-identity-security/managed-identities.md" "$(generate_template 'Managed Identities' 'identity and access')"
create_file "06-identity-security/azure-key-vault.md" "$(generate_template 'Azure Key Vault' 'secrets management')"
create_file "06-identity-security/rbac.md" "$(generate_template 'Role-Based Access Control (RBAC)' 'access control')"
create_file "06-identity-security/azure-security-center.md" "$(generate_template 'Azure Security Center' 'security posture')"

echo -e "${BLUE}⭐ 07-AZURE-DEVOPS (6 files - PRIORITY)...${NC}"

create_file "07-azure-devops/devops-overview.md" "$(generate_template 'Azure DevOps Overview' 'DevOps')"
create_file "07-azure-devops/azure-repos.md" "$(generate_template 'Azure Repos' 'Git repositories')"
create_file "07-azure-devops/azure-pipelines.md" "$(generate_template 'Azure Pipelines (CI/CD)' 'CI/CD')"
create_file "07-azure-devops/azure-artifacts.md" "$(generate_template 'Azure Artifacts' 'package management')"
create_file "07-azure-devops/azure-boards.md" "$(generate_template 'Azure Boards' 'project management')"
create_file "07-azure-devops/azure-test-plans.md" "$(generate_template 'Azure Test Plans' 'testing')"

echo -e "${BLUE}⭐ 08-DEVOPS-DEPENDENCIES (5 files - PRIORITY)...${NC}"

create_file "08-devops-dependencies/azure-container-registry.md" "$(generate_template 'Azure Container Registry (ACR)' 'container images')"
create_file "08-devops-dependencies/arm-templates.md" "$(generate_template 'ARM Templates' 'infrastructure as code')"
create_file "08-devops-dependencies/terraform-azure.md" "$(generate_template 'Terraform on Azure' 'infrastructure as code')"
create_file "08-devops-dependencies/azure-monitor.md" "$(generate_template 'Azure Monitor' 'monitoring and diagnostics')"
create_file "08-devops-dependencies/log-analytics.md" "$(generate_template 'Log Analytics' 'log management')"

echo -e "${BLUE}📂 09-ADVANCED (6 files)...${NC}"

create_file "09-advanced/azure-service-bus.md" "$(generate_template 'Azure Service Bus' 'messaging')"
create_file "09-advanced/azure-event-grid.md" "$(generate_template 'Azure Event Grid' 'event routing')"
create_file "09-advanced/azure-logic-apps.md" "$(generate_template 'Azure Logic Apps' 'workflow automation')"
create_file "09-advanced/disaster-recovery.md" "$(generate_template 'Disaster Recovery' 'business continuity')"
create_file "09-advanced/cost-optimization.md" "$(generate_template 'Cost Optimization' 'cost management')"
create_file "09-advanced/well-architected-framework.md" "$(generate_template 'Well-Architected Framework' 'architecture')"

echo ""
echo -e "${GREEN}✅ Success!${NC}"
echo ""
echo "Created $count files with structured templates."
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Review the generated files"
echo "2. Expand templates with detailed content as needed"
echo "3. Commit and push:"
echo "   git add ."
echo "   git commit -m 'Add remaining Azure documentation files'"
echo "   git push origin main"
echo ""
echo -e "${BLUE}Repository structure is now complete!${NC}"
echo "All 40 files are now in place."
