# Azure Virtual Machines

## What are Azure Virtual Machines?

Azure Virtual Machines (VMs) provide on-demand, scalable computing resources with Infrastructure as a Service (IaaS). You get the flexibility of virtualization without having to buy and maintain physical hardware.

### Key Use Cases

- **Development and Testing** - Quick and easy creation of test environments
- **Running Applications** - Deploy enterprise applications in the cloud
- **DevOps Build Agents** - Self-hosted agents for Azure Pipelines
- **Disaster Recovery** - Failover infrastructure
- **Migration** - Lift-and-shift from on-premises

## VM Basics

### Components

Every Azure VM includes:

```
Virtual Machine
├── Compute (CPU/RAM)
├── OS Disk (required)
├── Data Disks (optional)
├── Network Interface (NIC)
├── Network Security Group (NSG)
├── Public/Private IP
└── Virtual Network (VNet)
```

### VM Series (Families)

Azure offers specialized VM types:

#### General Purpose (B, D, DS, A)
- Balanced CPU-to-memory ratio
- **Use cases**: Dev/test, small-medium databases, web servers
- **Example**: Standard_B2s, Standard_D2s_v5

#### Compute Optimized (F, FS)
- High CPU-to-memory ratio
- **Use cases**: Batch processing, web servers, analytics
- **Example**: Standard_F4s_v2

#### Memory Optimized (E, ES, M)
- High memory-to-CPU ratio
- **Use cases**: Large databases, in-memory analytics
- **Example**: Standard_E4s_v5

#### Storage Optimized (L, LS)
- High disk throughput and IO
- **Use cases**: Big data, SQL, NoSQL databases
- **Example**: Standard_L8s_v3

#### GPU (N-series)
- GPU-accelerated computing
- **Use cases**: AI/ML, rendering, video encoding
- **Example**: Standard_NC6s_v3

## Creating a Virtual Machine

### Using Azure Portal

**Step 1: Basics**
1. Navigate to **Virtual machines**
2. Click **+ Create** → **Azure virtual machine**
3. Fill in:
   - Subscription
   - Resource group
   - VM name
   - Region
   - Availability options
   - Image (OS)
   - Size

**Step 2: Administrator Account**
- Authentication type (SSH/Password)
- Username
- SSH key or password

**Step 3: Disks**
- OS disk type (Premium SSD, Standard SSD, Standard HDD)
- Additional data disks

**Step 4: Networking**
- Virtual network
- Subnet
- Public IP
- NIC network security group

**Step 5: Management**
- Monitoring
- Auto-shutdown
- Backup

**Step 6: Review + Create**

### Using Azure CLI

```bash
# Create Linux VM
az vm create \
  --resource-group myResourceGroup \
  --name myVM \
  --image UbuntuLTS \
  --size Standard_B2s \
  --admin-username azureuser \
  --generate-ssh-keys \
  --public-ip-sku Standard

# Create Windows VM
az vm create \
  --resource-group myResourceGroup \
  --name myWindowsVM \
  --image Win2022Datacenter \
  --size Standard_D2s_v5 \
  --admin-username azureadmin \
  --admin-password 'ComplexP@ssw0rd!' \
  --public-ip-sku Standard
```

### Using PowerShell

```powershell
# Create Linux VM
New-AzVm `
  -ResourceGroupName 'myResourceGroup' `
  -Name 'myVM' `
  -Location 'EastUS' `
  -Image 'UbuntuLTS' `
  -Size 'Standard_B2s' `
  -Credential (Get-Credential)

# Create Windows VM
New-AzVm `
  -ResourceGroupName 'myResourceGroup' `
  -Name 'myWindowsVM' `
  -Location 'EastUS' `
  -Image 'Win2022Datacenter' `
  -Size 'Standard_D2s_v5' `
  -Credential (Get-Credential)
```

## VM Management

### Start/Stop/Restart

```bash
# Start VM
az vm start --resource-group myRG --name myVM

# Stop (deallocate) VM
az vm deallocate --resource-group myRG --name myVM

# Restart VM
az vm restart --resource-group myRG --name myVM

# Delete VM
az vm delete --resource-group myRG --name myVM --yes
```

### Connecting to VMs

#### SSH (Linux)

```bash
# Get public IP
az vm show --resource-group myRG --name myVM --show-details --query publicIps -o tsv

# Connect
ssh azureuser@<PUBLIC_IP>

# Or use Azure CLI
az ssh vm --resource-group myRG --name myVM
```

#### RDP (Windows)

```bash
# Download RDP file
az vm show --resource-group myRG --name myWindowsVM --show-details --query publicIps -o tsv

# Connect using Remote Desktop
# Use public IP with downloaded RDP file
```

## VM for DevOps (Self-Hosted Agents)

### Why Use VMs for Azure Pipelines?

- **Custom software requirements**
- **Specific OS versions**
- **Hardware requirements (GPU)**
- **Long-running jobs**
- **Access to on-premises resources**

### Setting Up Build Agent VM

```bash
# 1. Create VM
az vm create \
  --resource-group rg-devops \
  --name agent-vm-01 \
  --image UbuntuLTS \
  --size Standard_D4s_v5 \
  --admin-username buildagent \
  --generate-ssh-keys

# 2. Install agent (on VM)
wget https://vstsagentpackage.azureedge.net/agent/2.x.x/vsts-agent-linux-x64-2.x.x.tar.gz
mkdir myagent && cd myagent
tar zxvf ../vsts-agent-linux-x64-2.x.x.tar.gz
./config.sh
./run.sh
```

### Agent VM Best Practices

✅ **DO:**
- Use Standard SSD or Premium SSD
- Size appropriately (D-series recommended)
- Enable auto-shutdown for cost savings
- Use managed identities for authentication
- Keep agent software updated

❌ **DON'T:**
- Use B-series for production builds
- Leave running 24/7 unnecessarily
- Store credentials on VM

## Disk Management

### Attach Data Disk

```bash
# Create and attach managed disk
az vm disk attach \
  --resource-group myRG \
  --vm-name myVM \
  --name myDataDisk \
  --size-gb 128 \
  --sku Premium_LRS \
  --new
```

### Disk Types Comparison

| Disk Type | IOPS | Throughput | Use Case | Price |
|-----------|------|------------|----------|-------|
| Ultra SSD | 160,000 | 4,000 MB/s | Mission-critical | $$$$$ |
| Premium SSD v2 | 80,000 | 1,200 MB/s | High performance | $$$$ |
| Premium SSD | 20,000 | 900 MB/s | Production workloads | $$$ |
| Standard SSD | 6,000 | 750 MB/s | Web servers, dev/test | $$ |
| Standard HDD | 2,000 | 500 MB/s | Backup, archives | $ |

## Availability and Scaling

### Availability Sets

Protect against planned and unplanned outages.

```bash
# Create availability set
az vm availability-set create \
  --resource-group myRG \
  --name myAvailSet \
  --platform-fault-domain-count 2 \
  --platform-update-domain-count 5

# Create VM in availability set
az vm create \
  --resource-group myRG \
  --name myVM \
  --availability-set myAvailSet \
  --image UbuntuLTS
```

**Provides:**
- 99.95% SLA
- Protection across fault domains
- Protection during maintenance

### Availability Zones

Physically separate locations within a region.

```bash
# Create VM in specific zone
az vm create \
  --resource-group myRG \
  --name myVM \
  --image UbuntuLTS \
  --zone 1
```

**Provides:**
- 99.99% SLA (2+ VMs across zones)
- Protection against datacenter failures

### Virtual Machine Scale Sets (VMSS)

Automatically scale VMs based on demand.

```bash
# Create VMSS
az vmss create \
  --resource-group myRG \
  --name myScaleSet \
  --image UbuntuLTS \
  --instance-count 2 \
  --vm-sku Standard_D2s_v5 \
  --upgrade-policy-mode automatic

# Scale out
az vmss scale --resource-group myRG --name myScaleSet --new-capacity 5

# Enable autoscale
az monitor autoscale create \
  --resource-group myRG \
  --resource myScaleSet \
  --resource-type Microsoft.Compute/virtualMachineScaleSets \
  --name autoscale \
  --min-count 2 \
  --max-count 10 \
  --count 2
```

## Security

### Network Security Groups (NSG)

```bash
# Create NSG rule
az network nsg rule create \
  --resource-group myRG \
  --nsg-name myNSG \
  --name AllowSSH \
  --priority 1000 \
  --source-address-prefixes '*' \
  --destination-port-ranges 22 \
  --access Allow \
  --protocol Tcp
```

### Managed Identities

Assign Azure AD identity to VM.

```bash
# Enable system-assigned identity
az vm identity assign --resource-group myRG --name myVM

# Grant permissions
az role assignment create \
  --assignee <PRINCIPAL_ID> \
  --role Contributor \
  --scope /subscriptions/<SUB_ID>/resourceGroups/myRG
```

### Azure Bastion

Secure RDP/SSH without public IP.

```bash
# Create Bastion
az network bastion create \
  --name myBastion \
  --public-ip-address myBastionIP \
  --resource-group myRG \
  --vnet-name myVNet
```

## Monitoring

### Enable Boot Diagnostics

```bash
az vm boot-diagnostics enable \
  --resource-group myRG \
  --name myVM
```

### Install Azure Monitor Agent

```bash
# Install extension
az vm extension set \
  --publisher Microsoft.Azure.Monitor \
  --name AzureMonitorLinuxAgent \
  --resource-group myRG \
  --vm-name myVM
```

### Key Metrics to Monitor

- CPU utilization
- Memory usage
- Disk IOPS
- Network in/out
- Available memory bytes

## Backup and Disaster Recovery

### Azure Backup

```bash
# Enable backup
az backup protection enable-for-vm \
  --resource-group myRG \
  --vault-name myRecoveryServicesVault \
  --vm myVM \
  --policy-name DefaultPolicy
```

### Snapshots

```bash
# Create snapshot
az snapshot create \
  --resource-group myRG \
  --name mySnapshot \
  --source myDisk

# Create VM from snapshot
az vm create \
  --resource-group myRG \
  --name myRestoredVM \
  --attach-os-disk mySnapshot \
  --os-type Linux
```

## Cost Optimization

### Reserved Instances

- 1-year: Up to 40% savings
- 3-year: Up to 72% savings

### Spot VMs

```bash
# Create Spot VM
az vm create \
  --resource-group myRG \
  --name mySpotVM \
  --image UbuntuLTS \
  --priority Spot \
  --max-price 0.05 \
  --eviction-policy Deallocate
```

**Savings**: Up to 90%
**Risk**: Can be evicted anytime

### Auto-Shutdown

```bash
# Configure auto-shutdown
az vm auto-shutdown \
  --resource-group myRG \
  --name myVM \
  --time 1900
```

### Right-Sizing

```bash
# Resize VM
az vm resize \
  --resource-group myRG \
  --name myVM \
  --size Standard_B2s
```

## Common Scenarios

### Scenario 1: Web Server

```yaml
Requirements:
- Linux web server
- Public access
- Cost-effective

Solution:
- Size: Standard_B2s
- Image: Ubuntu LTS
- Disk: Standard SSD
- NSG: Allow ports 80, 443
```

### Scenario 2: DevOps Build Agent

```yaml
Requirements:
- Fast builds
- Docker support
- Reliable

Solution:
- Size: Standard_D4s_v5
- Image: Ubuntu LTS  
- Disk: Premium SSD
- Additional: Docker, build tools pre-installed
```

### Scenario 3: Database Server

```yaml
Requirements:
- High memory
- Fast disk IO
- High availability

Solution:
- Size: Standard_E8s_v5 (memory-optimized)
- Disk: Premium SSD (P30)
- Availability: Availability Zone
- Backup: Daily automated backups
```

## Troubleshooting

### VM Won't Start

```bash
# Check VM status
az vm get-instance-view --resource-group myRG --name myVM

# View boot diagnostics
az vm boot-diagnostics get-boot-log --resource-group myRG --name myVM
```

### Performance Issues

```bash
# Check metrics
az monitor metrics list \
  --resource /subscriptions/{sub}/resourceGroups/myRG/providers/Microsoft.Compute/virtualMachines/myVM \
  --metric "Percentage CPU"
```

### Connection Issues

```bash
# Reset SSH
az vm user reset-ssh --resource-group myRG --name myVM

# Reset password
az vm user update \
  --resource-group myRG \
  --name myVM \
  --username azureuser \
  --password NewP@ssw0rd!
```

## Best Practices Summary

✅ **DO:**
- Use managed disks
- Enable boot diagnostics
- Implement backup strategy
- Use availability zones/sets for production
- Apply security patches regularly
- Tag resources appropriately
- Use managed identities
- Right-size VMs

❌ **DON'T:**
- Leave default passwords
- Skip NSG configuration
- Ignore monitoring
- Over-provision resources
- Forget to set auto-shutdown
- Store secrets on VM

## Quick Reference Commands

```bash
# List VMs
az vm list --output table

# Get VM details
az vm show --resource-group myRG --name myVM

# Start/Stop
az vm start --resource-group myRG --name myVM
az vm deallocate --resource-group myRG --name myVM

# Resize
az vm resize --resource-group myRG --name myVM --size Standard_D4s_v5

# Get public IP
az vm list-ip-addresses --resource-group myRG --name myVM --output table

# Run command on VM
az vm run-command invoke \
  --resource-group myRG \
  --name myVM \
  --command-id RunShellScript \
  --scripts "echo Hello World"
```

## Next Steps

- [Azure Kubernetes Service](azure-kubernetes-service.md)
- [Virtual Machine Scale Sets](vm-scale-sets.md)
- [Azure DevOps Agents](../07-azure-devops/azure-pipelines.md)

---

**Pro Tip**: For DevOps build agents, start with D-series VMs. They provide the best balance of compute power and cost for most build workloads.
