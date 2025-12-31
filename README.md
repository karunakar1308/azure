# Azure Learning Repository

Comprehensive guide to Microsoft Azure covering fundamental to advanced concepts, with emphasis on the most commonly used services and Azure DevOps dependencies.

## 📚 Repository Structure

This repository is organized into clear, focused modules from basic to advanced topics. Each topic is in its own file to prevent clutter and improve readability.

### 📂 01-Fundamentals
- [Cloud Computing Basics](01-fundamentals/cloud-computing-basics.md)
- [Azure Account Setup](01-fundamentals/azure-account-setup.md)
- [Azure Portal Navigation](01-fundamentals/azure-portal-navigation.md)
- [Resource Groups and Subscriptions](01-fundamentals/resource-groups-subscriptions.md)
- [Azure Regions and Availability Zones](01-fundamentals/regions-availability-zones.md)

### 📂 02-Core-Compute-Services
- [Azure Virtual Machines (VMs)](02-core-compute/azure-virtual-machines.md)
- [Azure App Service](02-core-compute/azure-app-service.md)
- [Azure Kubernetes Service (AKS)](02-core-compute/azure-kubernetes-service.md)
- [Azure Functions (Serverless)](02-core-compute/azure-functions.md)
- [Azure Container Instances (ACI)](02-core-compute/azure-container-instances.md)

### 📂 03-Networking
- [Azure Virtual Networks (VNet)](03-networking/azure-virtual-networks.md)
- [Network Security Groups (NSG)](03-networking/network-security-groups.md)
- [Azure Load Balancer](03-networking/azure-load-balancer.md)
- [Application Gateway](03-networking/application-gateway.md)
- [Azure VPN and ExpressRoute](03-networking/vpn-expressroute.md)

### 📂 04-Storage-Services
- [Azure Blob Storage](04-storage/azure-blob-storage.md)
- [Azure Files](04-storage/azure-files.md)
- [Azure Disk Storage](04-storage/azure-disk-storage.md)
- [Azure Storage Accounts](04-storage/storage-accounts.md)

### 📂 05-Database-Services
- [Azure SQL Database](05-databases/azure-sql-database.md)
- [Azure Cosmos DB](05-databases/azure-cosmos-db.md)
- [Azure Database for PostgreSQL/MySQL](05-databases/azure-postgresql-mysql.md)
- [Azure Cache for Redis](05-databases/azure-redis-cache.md)

### 📂 06-Identity-and-Security
- [Azure Active Directory (Entra ID)](06-identity-security/azure-active-directory.md)
- [Managed Identities](06-identity-security/managed-identities.md)
- [Azure Key Vault](06-identity-security/azure-key-vault.md)
- [Role-Based Access Control (RBAC)](06-identity-security/rbac.md)
- [Azure Security Center](06-identity-security/azure-security-center.md)

### 📂 07-Azure-DevOps ⭐ (Emphasis)
- [Azure DevOps Overview](07-azure-devops/devops-overview.md)
- [Azure Repos (Git)](07-azure-devops/azure-repos.md)
- [Azure Pipelines (CI/CD)](07-azure-devops/azure-pipelines.md)
- [Azure Artifacts](07-azure-devops/azure-artifacts.md)
- [Azure Boards](07-azure-devops/azure-boards.md)
- [Azure Test Plans](07-azure-devops/azure-test-plans.md)

### 📂 08-DevOps-Dependencies
- [Azure Container Registry (ACR)](08-devops-dependencies/azure-container-registry.md)
- [Azure Resource Manager (ARM) Templates](08-devops-dependencies/arm-templates.md)
- [Infrastructure as Code with Terraform](08-devops-dependencies/terraform-azure.md)
- [Azure Monitor and Application Insights](08-devops-dependencies/azure-monitor.md)
- [Azure Log Analytics](08-devops-dependencies/log-analytics.md)

### 📂 09-Advanced-Topics
- [Azure Service Bus](09-advanced/azure-service-bus.md)
- [Azure Event Grid](09-advanced/azure-event-grid.md)
- [Azure Logic Apps](09-advanced/azure-logic-apps.md)
- [Disaster Recovery and High Availability](09-advanced/disaster-recovery.md)
- [Cost Optimization Strategies](09-advanced/cost-optimization.md)
- [Well-Architected Framework](09-advanced/well-architected-framework.md)

## 🎯 Top 15 Most Used Azure Services

1. **Azure Virtual Machines** - IaaS compute service
2. **Azure App Service** - PaaS web app hosting
3. **Azure Kubernetes Service (AKS)** - Container orchestration
4. **Azure Storage (Blob, Files, Disks)** - Scalable storage solutions
5. **Azure SQL Database** - Managed relational database
6. **Azure Active Directory** - Identity and access management
7. **Azure DevOps** - Complete DevOps toolchain
8. **Azure Functions** - Serverless computing
9. **Azure Key Vault** - Secrets management
10. **Azure Virtual Networks** - Network isolation and connectivity
11. **Azure Monitor** - Monitoring and diagnostics
12. **Azure Container Registry** - Container image management
13. **Azure Load Balancer** - Load distribution
14. **Azure Cosmos DB** - Globally distributed NoSQL database
15. **Azure Cache for Redis** - In-memory data store

## 🔄 Azure DevOps Service Dependencies

Azure DevOps relies heavily on these Azure services:

- **Azure Container Registry (ACR)** - Store and manage container images for deployments
- **Azure Key Vault** - Securely store credentials, secrets, and certificates used in pipelines
- **Azure Resource Manager (ARM)** - Deploy and manage infrastructure
- **Azure Virtual Machines/AKS** - Deployment targets for applications
- **Azure Storage** - Artifact storage and backup
- **Azure Monitor & Application Insights** - Monitor deployed applications
- **Azure Active Directory** - Authentication and authorization
- **Azure Repos** - Git repository hosting (part of Azure DevOps)
- **Azure Pipelines** - CI/CD automation (part of Azure DevOps)

## 🚀 Learning Path

**Beginners (Weeks 1-2):**
1. Start with 01-Fundamentals
2. Explore Azure Portal
3. Create your first Virtual Machine
4. Set up basic networking

**Intermediate (Weeks 3-4):**
1. Learn Azure App Service
2. Understand Azure Storage options
3. Work with Azure SQL Database
4. Explore Azure Active Directory basics

**DevOps Focus (Weeks 5-6):**
1. Complete 07-Azure-DevOps section
2. Study 08-DevOps-Dependencies
3. Create your first CI/CD pipeline
4. Integrate with Azure services

**Advanced (Weeks 7+):**
1. Dive into container technologies (AKS)
2. Master Infrastructure as Code
3. Implement monitoring and logging
4. Learn cost optimization techniques

## 📖 How to Use This Repository

1. **Sequential Learning**: Follow the numbered folders from 01 to 09
2. **Topic-Based**: Jump to specific services you need to learn
3. **DevOps Focused**: Prioritize folders 07 and 08 for DevOps specialization
4. **Hands-On**: Each file includes practical examples and exercises

## 🛠️ Prerequisites

- Active Azure subscription (free tier available)
- Basic understanding of cloud computing concepts
- Familiarity with command line/terminal
- For DevOps sections: Basic Git knowledge

## 📝 Contributing

Feel free to contribute by adding examples, corrections, or new topics following the existing structure.

## 📌 Quick Links

- [Azure Portal](https://portal.azure.com)
- [Azure Documentation](https://docs.microsoft.com/azure)
- [Azure DevOps Services](https://dev.azure.com)
- [Azure Free Account](https://azure.microsoft.com/free)

---

**Last Updated**: December 2025
