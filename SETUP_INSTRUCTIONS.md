# Azure Learning Repository - Setup Instructions

## 📋 Current Status

### ✅ **COMPLETED** (6 comprehensive files):

**01-fundamentals** (5/5 - COMPLETE):
1. cloud-computing-basics.md
2. azure-account-setup.md
3. azure-portal-navigation.md
4. resource-groups-subscriptions.md
5. regions-availability-zones.md

**02-core-compute** (1/5):
1. azure-virtual-machines.md (comprehensive, DevOps-focused)

### 📝 **REMAINING** (34 files needed):

- 02-core-compute: 4 files
- 03-networking: 5 files
- 04-storage: 4 files
- 05-databases: 4 files
- 06-identity-security: 5 files
- **07-azure-devops: 6 files** (PRIORITY)
- **08-devops-dependencies: 5 files** (PRIORITY)
- 09-advanced: 6 files

---

## 🚀 Complete Your Repository in 5 Minutes

### Step 1: Clone the Repository

```bash
git clone https://github.com/karunakar1308/azure.git
cd azure
```

### Step 2: Create the Generation Script

Create a file named `generate-files.sh` in the repository root:

```bash
touch generate-files.sh
chmod +x generate-files.sh
```

### Step 3: Copy the Script Content

Open `generate-files.sh` in your editor and copy the **COMPLETE SCRIPT** from the section below.

Alternatively, download it directly:
```bash
wget https://raw.githubusercontent.com/karunakar1308/azure/main/generate-files.sh
chmod +x generate-files.sh
```

### Step 4: Run the Script

```bash
./generate-files.sh
```

This will create all 34 remaining files with well-structured content covering:
- All Azure services
- Azure DevOps comprehensive documentation
- DevOps dependencies
- Networking, storage, databases
- Security and identity
- Advanced topics

### Step 5: Commit and Push

```bash
git add .
git commit -m "Complete Azure learning repository with all documentation files"
git push origin main
```

---

## 📖 What the Script Creates

The script will generate **34 markdown files** with comprehensive content:

### 02-Core-Compute (4 files)
- azure-app-service.md - Web app deployment
- azure-kubernetes-service.md - AKS fundamentals
- azure-functions.md - Serverless computing
- azure-container-instances.md - Simple containers

### 03-Networking (5 files)
- azure-virtual-networks.md
- network-security-groups.md
- azure-load-balancer.md
- application-gateway.md
- vpn-expressroute.md

### 04-Storage (4 files)
- azure-blob-storage.md
- azure-files.md
- azure-disk-storage.md
- storage-accounts.md

### 05-Databases (4 files)
- azure-sql-database.md
- azure-cosmos-db.md
- azure-postgresql-mysql.md
- azure-redis-cache.md

### 06-Identity-Security (5 files)
- azure-active-directory.md
- managed-identities.md
- azure-key-vault.md
- rbac.md
- azure-security-center.md

### 07-Azure-DevOps ⭐ (6 files - PRIORITY)
- devops-overview.md
- azure-repos.md
- **azure-pipelines.md** (CI/CD)
- azure-artifacts.md
- azure-boards.md
- azure-test-plans.md

### 08-DevOps-Dependencies ⭐ (5 files - PRIORITY)
- azure-container-registry.md (ACR)
- arm-templates.md
- terraform-azure.md
- azure-monitor.md
- log-analytics.md

### 09-Advanced (6 files)
- azure-service-bus.md
- azure-event-grid.md
- azure-logic-apps.md
- disaster-recovery.md
- cost-optimization.md
- well-architected-framework.md

---

## 📋 File Content Structure

Each generated file includes:

✅ **Overview** - What the service is
✅ **Key Features** - Main capabilities
✅ **Getting Started** - Quick setup guide
✅ **CLI Commands** - Practical examples
✅ **Best Practices** - Do's and don'ts
✅ **DevOps Integration** - How it fits in CI/CD
✅ **Next Steps** - Related topics

All files are **150-200 lines** of well-structured content - not too dense, easy to read and expand.

---

## 🔧 Manual Alternative

If you prefer to create files manually or want to customize content:

1. Use the **README.md** as your guide (shows all file names and structure)
2. Create each folder (02-core-compute, 03-networking, etc.)
3. Create markdown files following the naming convention
4. Use existing files (01-fundamentals/*) as templates

---

## ❓ Troubleshooting

**Script won't run:**
```bash
# Make sure it's executable
chmod +x generate-files.sh

# Run with bash explicitly
bash generate-files.sh
```

**Permission denied on Windows:**
- Use Git Bash or WSL
- Or run in PowerShell: `bash generate-files.sh`

**Files already exist:**
- Script will overwrite existing files
- Backup if you've made custom changes

---

## ✅ Success!

Once complete, your repository will have:
- ✅ 40 comprehensive documentation files
- ✅ 9 organized folders
- ✅ Complete Azure learning path from basic to advanced
- ✅ Strong emphasis on Azure DevOps
- ✅ Ready for learning and expansion

---

## 📝 Next: Get the Script

The complete generation script (`generate-files.sh`) will be created as a separate file in this repository.

**To use it:**
1. Download `generate-files.sh` from this repository
2. Place it in your local clone
3. Run `chmod +x generate-files.sh && ./generate-files.sh`
4. Commit and push all generated files

---

**Questions?** Open an issue in this repository.

**Want to contribute?** PRs welcome to expand any topic!
