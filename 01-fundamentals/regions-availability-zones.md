# Azure Regions and Availability Zones

## Azure Regions

### What is an Azure Region?

An Azure region is a set of datacenters deployed within a latency-defined perimeter and connected through a dedicated regional low-latency network.

### Key Facts

- **60+ regions** worldwide
- More global regions than any other cloud provider
- Available in **140+ countries**
- Each region contains multiple datacenters

### Region Types

#### 1. Public Regions
Standard regions available to all Azure customers

**Examples:**
- East US
- West Europe
- Southeast Asia
- Japan East

#### 2. Sovereign/Government Regions  
Isolated instances for compliance and regulatory requirements

**Examples:**
- Azure Government (US Government)
- Azure China (operated by 21Vianet)
- Azure Germany

### Major Azure Regions

#### Americas
- **East US** (Virginia)
- **East US 2** (Virginia)
- **West US** (California)
- **West US 2** (Washington)
- **West US 3** (Arizona)
- **Central US** (Iowa)
- **Canada Central** (Toronto)
- **Brazil South** (Sao Paulo)

#### Europe
- **North Europe** (Ireland)
- **West Europe** (Netherlands)
- **UK South** (London)
- **UK West** (Cardiff)
- **France Central** (Paris)
- **Germany West Central** (Frankfurt)
- **Switzerland North** (Zurich)

#### Asia Pacific
- **Southeast Asia** (Singapore)
- **East Asia** (Hong Kong)
- **Japan East** (Tokyo)
- **Japan West** (Osaka)
- **Australia East** (Sydney)
- **Australia Southeast** (Melbourne)
- **Central India** (Pune)
- **South India** (Chennai)
- **Korea Central** (Seoul)

## Availability Zones

### What are Availability Zones?

Availability Zones are physically separate locations within an Azure region, each with independent power, cooling, and networking.

### Key Characteristics

- **Minimum 3 zones** per enabled region
- Physically separated (miles apart)
- Connected via high-speed private fiber network
- Protect against datacenter failures

### Architecture

```
Azure Region (e.g., East US)
├── Availability Zone 1
│   ├── Datacenter 1A
│   └── Datacenter 1B
│
├── Availability Zone 2  
│   ├── Datacenter 2A
│   └── Datacenter 2B
│
└── Availability Zone 3
    ├── Datacenter 3A
    └── Datacenter 3B
```

### Availability Zone Services

#### Zone-Redundant Services
Automatically replicated across zones

**Examples:**
- Azure SQL Database (Premium/Business Critical)
- Azure Storage (ZRS)
- Azure Application Gateway
- Load Balancer (Standard)

#### Zonal Services  
Deployed to specific zone(s)

**Examples:**
- Virtual Machines
- Managed Disks
- Standard IP addresses

## Region Pairs

### What are Region Pairs?

Each Azure region is paired with another region within the same geography for disaster recovery purposes.

### Characteristics

- **Minimum 300 miles apart**
- Platform updates rolled out sequentially
- Data residency maintained
- Priority region recovery during outages

### Example Region Pairs

| Primary Region | Paired Region |
|----------------|---------------|
| East US | West US |
| East US 2 | Central US |
| North Europe | West Europe |
| Southeast Asia | East Asia |
| UK South | UK West |
| Japan East | Japan West |

### Benefits

1. **Sequential Updates**: Only one region updated at a time
2. **Priority Recovery**: At least one region prioritized
3. **Data Residency**: Same geography (except Brazil South)
4. **Replication**: Geo-redundant storage replicates automatically

## Choosing a Region

### Factors to Consider

#### 1. Proximity to Users
- Lower latency
- Better user experience
- Compliance with data residency laws

#### 2. Service Availability
- Not all services available in all regions
- Check [Azure Products by Region](https://azure.microsoft.com/global-infrastructure/services/)

#### 3. Cost
- Pricing varies by region
- Check pricing calculator

#### 4. Compliance
- Data residency requirements
- Regulatory compliance
- Industry certifications

#### 5. Capacity
- Some regions may have capacity constraints
- Plan for growth

### CLI Commands

```bash
# List all regions
az account list-locations --output table

# List regions for specific service
az provider show --namespace Microsoft.Compute --query "resourceTypes[?resourceType=='virtualMachines'].locations"
```

## High Availability Strategies

### Level 1: Single Region, Single Zone

**Availability**: ~99.9%

```
[VM] → Single Datacenter
```

**Use Case**: Development/test environments

### Level 2: Single Region, Multiple Zones

**Availability**: ~99.99%

```
[VM-Zone1] ↔ [VM-Zone2] ↔ [VM-Zone3]
       │           │           │
    [Load Balancer (Zone-Redundant)]
```

**Use Case**: Production workloads requiring high availability

### Level 3: Multiple Regions (Active-Passive)

**Availability**: ~99.99%+

```
Primary Region          Secondary Region
[VM-Active]     →→→     [VM-Standby]
[Data-Active]   →→→     [Data-Replica]
       │                     │
   [Traffic Manager/Front Door]
```

**Use Case**: Business-critical applications

### Level 4: Multiple Regions (Active-Active)

**Availability**: ~99.999%

```
Region 1               Region 2
[VM-Active] ↔↔↔↔↔ [VM-Active]
[Data-Sync] ↔↔↔↔↔ [Data-Sync]
      │                    │
      [Global Load Balancer]
```

**Use Case**: Mission-critical, globally distributed applications

## Storage Redundancy Options

### Locally Redundant Storage (LRS)
- 3 copies within single datacenter
- **Durability**: 11 nines (99.999999999%)
- Lowest cost

### Zone-Redundant Storage (ZRS)
- 3 copies across 3 availability zones
- **Durability**: 12 nines
- Protects against datacenter failure

### Geo-Redundant Storage (GRS)
- LRS in primary + LRS in paired region
- **Durability**: 16 nines
- Async replication

### Geo-Zone-Redundant Storage (GZRS)
- ZRS in primary + LRS in paired region
- **Durability**: 16 nines
- Maximum protection

## Service Level Agreements (SLAs)

### Single Instance VMs
- Premium SSD: **99.9%**
- Standard SSD: **99.5%**
- Standard HDD: **95%**

### Availability Sets
- **99.95%** uptime
- 2 or more VMs across fault/update domains

### Availability Zones
- **99.99%** uptime
- 2 or more VMs across zones

### Multiple Regions
- **99.99%+** depending on configuration
- With Traffic Manager/Front Door

## Practical Examples

### Example 1: Deploy VM in Specific Zone

```bash
# Create VM in Zone 1
az vm create \
  --resource-group myRG \
  --name myVM \
  --image UbuntuLTS \
  --zone 1 \
  --location eastus
```

### Example 2: Create Zone-Redundant Storage

```bash
# Create storage account with ZRS
az storage account create \
  --name mystorageaccount \
  --resource-group myRG \
  --location eastus \
  --sku Standard_ZRS
```

### Example 3: Multi-Region Deployment

```bash
# Deploy to primary region
az group create --name myRG-eastus --location eastus
az vm create --resource-group myRG-eastus --name vm-east --image UbuntuLTS

# Deploy to secondary region
az group create --name myRG-westus --location westus
az vm create --resource-group myRG-westus --name vm-west --image UbuntuLTS
```

## Azure Traffic Manager

Global DNS-based traffic load balancer for multi-region deployments.

### Routing Methods

1. **Priority**: Failover to secondary
2. **Weighted**: Distribute traffic by percentage
3. **Performance**: Route to closest region
4. **Geographic**: Route based on geo-location
5. **Multivalue**: Return multiple healthy endpoints
6. **Subnet**: Map IP ranges to endpoints

## Azure Front Door

Global, scalable entry point using Microsoft's global edge network.

### Features
- Application layer (HTTP/HTTPS) load balancing
- URL-based routing
- SSL offloading
- WAF integration
- Caching

## Cost Optimization

### Tips

1. **Choose right region**: Prices vary (up to 20% difference)
2. **Use reserved instances**: Up to 72% savings
3. **Right-size resources**: Don't over-provision
4. **Leverage Availability Zones**: Better than multiple regions for cost
5. **Use Azure Hybrid Benefit**: Bring your own licenses

### Price Comparison (Example: D2s v3 VM Monthly)

| Region | Price |
|--------|-------|
| East US | ~$70 |
| West US | ~$75 |
| West Europe | ~$80 |
| Brazil South | ~$100 |

*Prices approximate and change over time*

## Best Practices

### DO:
✅ Deploy across availability zones for production
✅ Use geo-redundant storage for critical data
✅ Test failover procedures regularly
✅ Consider data residency requirements
✅ Monitor region health status
✅ Document region selection rationale

### DON'T:
❌ Deploy all resources in single datacenter
❌ Ignore SLA requirements
❌ Forget to test disaster recovery
❌ Overlook compliance requirements
❌ Deploy to random regions

## Monitoring Region Health

### Azure Status Page

**URL**: https://status.azure.com

- Current service health
- Planned maintenance
- Historical incidents

### Service Health Dashboard

**Path**: Azure Portal → Service Health

- Personalized view
- Configured alerts
- Health advisories
- Planned maintenance notifications

## Common Scenarios

### Scenario 1: Single Region Application

```yaml
Requirements:
- 99.9% uptime
- Low latency for US users
- Budget conscious

Solution:
- Region: East US
- Availability Set (2+ VMs)
- Standard SSD disks
- LRS storage
```

### Scenario 2: High Availability

```yaml
Requirements:
- 99.99% uptime
- Datacenter failure protection
- Medium budget

Solution:
- Region: East US (Zone-enabled)
- Deploy across 2-3 Availability Zones
- Premium SSD disks
- ZRS storage
- Zone-redundant load balancer
```

### Scenario 3: Disaster Recovery

```yaml
Requirements:
- 99.99%+ uptime
- Region failure protection
- RTO < 1 hour

Solution:
- Primary: East US
- Secondary: West US  
- Geo-redundant storage
- Traffic Manager for failover
- Automated DR procedures
```

### Scenario 4: Global Application

```yaml
Requirements:
- Global user base
- Low latency worldwide
- 99.99% uptime

Solution:
- Regions: East US, West Europe, Southeast Asia
- Availability Zones in each region
- Azure Front Door for global routing
- Cosmos DB with multi-region writes
- CDN for static content
```

## Next Steps

- [Azure Virtual Machines](../02-core-compute/azure-virtual-machines.md)
- [Azure Storage Services](../04-storage/azure-blob-storage.md)
- [Disaster Recovery Planning](../09-advanced/disaster-recovery.md)

---

**Pro Tip**: Always deploy production workloads across at least 2 availability zones or regions. The marginal cost increase is worth the dramatic improvement in reliability.
