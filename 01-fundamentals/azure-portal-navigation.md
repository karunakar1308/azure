# Azure Portal Navigation

## What is Azure Portal?

The Azure Portal is a web-based, unified console providing an alternative to command-line tools. You can manage your entire Azure subscription using a graphical user interface.

**URL:** https://portal.azure.com

## Portal Layout

### Main Components

```
┌─────────────────────────────────────────────────┐
│ [≡] Azure Services [🔍 Search] [🔔] [⚙️] [👤]  │  ← Top Bar
├──────┬──────────────────────────────────────────┤
│      │                                          │
│ Nav  │          Main Content Area              │
│ Menu │          (Dashboard/Resources)          │
│      │                                          │
│      │                                          │
└──────┴──────────────────────────────────────────┘
```

### 1. Top Navigation Bar

**Left Side:**
- **☰ Menu** - Toggle left navigation panel
- **Microsoft Azure** - Home link
- **Search bar** - Global search for resources and services

**Right Side:**
- **🔔 Notifications** - View alerts and notifications
- **Cloud Shell** - Access command line interface
- **⚙️ Settings** - Portal settings and preferences
- **❓ Help** - Documentation and support
- **👤 Account** - Profile and subscription switching

### 2. Left Navigation Panel

**Favorites (Customizable):**
- Dashboard
- All services
- Resource groups
- All resources
- Recent

**Common Services:**
- Create a resource
- Home
- Virtual machines
- App Services
- SQL databases
- Storage accounts

### 3. Main Content Area

Displays:
- Dashboards
- Resource details
- Configuration pages
- Blade-based navigation

## Key Navigation Patterns

### Blade System

Azure Portal uses "blades" - sliding panels that open from right to left.

**Example Flow:**
```
Home → Resource Groups → Select RG → Resources → VM Details
  ↓        ↓              ↓             ↓          ↓
Blade 1  Blade 2       Blade 3       Blade 4   Blade 5
```

**Managing Blades:**
- Click **X** to close individual blades
- Click **←** to go back one level
- Use breadcrumb trail at top

### Search

**Global Search (Top Bar):**
- Type resource names, services, or commands
- Quick access to any Azure service
- Recent searches saved

**Search Examples:**
```
"virtual machines"  → Opens VM service
"myvm01"          → Navigates to specific VM
"cost"            → Opens Cost Management
```

**Keyboard Shortcut:** `G + /` or just `/`

## Essential Portal Features

### 1. Dashboard

**Purpose:** Customizable homepage with tiles/widgets

**Creating Dashboard:**
1. Navigate to **Dashboard**
2. Click **+ New dashboard**
3. Name your dashboard
4. Add tiles by dragging from Tile Gallery

**Common Tiles:**
- Resource groups
- Recent resources
- Service health
- Cost analysis
- Metrics charts
- Quick tasks

**Managing Dashboards:**
```
Dashboard → Edit → Add tiles → Done editing
```

### 2. Resource Groups View

**Path:** Home → Resource groups

**Features:**
- List all resource groups
- Filter by subscription, type, location
- Quick actions (Delete, Move, Tags)
- Cost analysis per group

### 3. All Resources View

**Path:** Home → All resources

**Capabilities:**
- View all resources across subscriptions
- Advanced filtering
- Column customization
- Bulk operations
- Export to CSV

**Filters:**
- Subscription
- Resource type
- Location
- Tags
- Resource group

### 4. Cloud Shell

**Access:** Click **>_** icon in top bar

**Options:**
- **Bash** - Linux shell with Azure CLI
- **PowerShell** - Windows PowerShell with Az module

**Features:**
- Pre-installed tools (git, terraform, kubectl)
- Persistent storage (5GB)
- Web-based code editor
- No local installation needed

**Quick Start:**
```bash
# Bash example
az vm list --output table

# PowerShell example  
Get-AzVM | Format-Table
```

### 5. Azure Advisor

**Path:** Search "Advisor"

**Provides recommendations for:**
- **Reliability** - Improve availability
- **Security** - Enhance protection
- **Performance** - Increase speed
- **Cost** - Reduce spending
- **Operational Excellence** - Best practices

### 6. Cost Management + Billing

**Path:** Search "Cost Management"

**Features:**
- Cost analysis
- Budgets and alerts
- Invoices
- Payment methods
- Subscriptions

**Key Views:**
- Current month spend
- Forecast
- Cost by resource/service
- Historical trends

## Keyboard Shortcuts

Speed up navigation with keyboard shortcuts:

| Shortcut | Action |
|----------|--------|
| `G + N` | Create new resource |
| `G + /` | Global search |
| `G + D` | Dashboard |
| `G + B` | Browse all resources |
| `/` | Focus search bar |
| `Esc` | Close blade/dialog |

**View all shortcuts:** Press `?` in portal

## Customizing the Portal

### 1. Theme and Appearance

**Path:** Settings ⚙️ → Appearance

**Options:**
- Light theme
- Dark theme
- High contrast themes

### 2. Language and Region

**Path:** Settings ⚙️ → Language + region

**Configure:**
- Portal language
- Regional format (date/time)
- Startup page

### 3. Directories and Subscriptions

**Path:** Settings ⚙️ → Directories + subscriptions

**Manage:**
- Switch between Azure AD tenants
- Filter subscriptions shown in portal
- Set default directory

### 4. Favorites

**Adding to Favorites:**
- Navigate to any service
- Click ⭐ star icon
- Service appears in left menu

**Reordering:**
- Click and drag in left navigation panel

## Resource Creation Workflow

### Standard Creation Process

**Step 1: Create a Resource**
```
Home → Create a resource → Search for service
```

**Step 2: Basic Configuration**
- Subscription
- Resource group (create new or use existing)
- Resource name
- Region

**Step 3: Additional Settings**
- Service-specific configuration
- Networking
- Management options
- Tags

**Step 4: Review + Create**
- Validation check
- Cost estimate
- Deployment details

**Step 5: Deployment**
- Monitor deployment progress
- View resources created
- Access deployment details

## Monitoring and Diagnostics

### Activity Log

**Path:** Any resource → Activity log

**Shows:**
- Who did what and when
- Operation results
- Resource changes
- Control plane activities

**Filtering:**
- Time range
- Event severity
- Operation type
- User/service principal

### Metrics

**Path:** Resource → Metrics

**Features:**
- Real-time resource metrics
- Custom time ranges
- Multiple metrics on single chart
- Pin charts to dashboard

**Common Metrics:**
- CPU usage
- Memory
- Network in/out
- Disk operations
- Request counts

### Alerts

**Path:** Resource → Alerts

**Create alerts for:**
- Metric thresholds
- Activity log events
- Service health

**Actions:**
- Email notifications
- Webhooks
- Logic Apps
- Azure Functions

## Portal Tips and Tricks

### 1. Quick Access

**Recent Resources:**
- Shows last 10-15 accessed resources
- Pin frequently used resources

**Breadcrumb Navigation:**
- Top of page shows current location
- Click any level to jump back

### 2. Resource Explorer

**Path:** Resource → Resource Explorer

- View raw ARM JSON
- See resource properties
- Understand resource structure

### 3. Export Template

**Path:** Resource group → Export template

- Download ARM template
- Automate deployments
- Infrastructure as Code

### 4. Bulk Operations

**In All Resources view:**
- Select multiple resources
- Perform bulk actions:
  - Add tags
  - Move
  - Delete
  - Assign policies

### 5. Portal Settings Sync

Settings sync across:
- Browsers
- Devices
- Locations

**Synced settings:**
- Favorites
- Dashboards
- Theme preferences

## Mobile App

**Azure Mobile App** (iOS/Android)

**Features:**
- View and manage resources
- Monitor service health
- Respond to alerts
- Run Cloud Shell commands
- View dashboards
- Manage support requests

**Download:**
- iOS: App Store
- Android: Google Play Store

## Common Tasks

### Task 1: Find a Specific Resource

```
1. Use global search (/)  
2. Type resource name
3. Select from results
```

### Task 2: Check Costs

```
1. Search "Cost Management"
2. Click "Cost analysis"
3. View current spend
4. Filter by resource group/service
```

### Task 3: Create Alert

```
1. Navigate to resource
2. Click "Alerts"
3. "+ New alert rule"
4. Configure condition and action
5. Save
```

### Task 4: Download Invoices

```
1. Search "Cost Management + Billing"
2. Click "Invoices"
3. Select invoice
4. Download PDF
```

### Task 5: Troubleshoot Resource

```
1. Navigate to resource
2. Click "Diagnose and solve problems"
3. Select issue category
4. Follow recommendations
```

## Best Practices

### Organization

✅ **DO:**
- Use consistent naming conventions
- Apply tags to resources
- Create custom dashboards
- Pin frequently used services
- Use resource groups logically

❌ **DON'T:**
- Leave too many blades open (slows portal)
- Forget to close unused resources
- Ignore cost alerts
- Skip tagging resources

### Performance

- Close unnecessary blades
- Use filters in large lists
- Use CLI/PowerShell for bulk operations
- Cache portal settings

### Security

- Enable MFA
- Use private browsing for sensitive accounts
- Log out when done
- Review activity logs regularly
- Use RBAC for access control

## Troubleshooting Portal Issues

### Portal Won't Load

1. Check internet connection
2. Clear browser cache
3. Try incognito/private mode
4. Try different browser
5. Check [Azure Status](https://status.azure.com)

### Resource Not Showing

1. Check subscription filter
2. Verify permissions (RBAC)
3. Refresh the page
4. Check resource wasn't deleted

### Slow Performance

1. Close excess blades
2. Clear browser cache
3. Disable browser extensions
4. Check network speed

## Next Steps

- [Azure Regions and Availability Zones](regions-availability-zones.md)
- [Azure Virtual Machines](../02-core-compute/azure-virtual-machines.md)
- [Azure CLI Basics](azure-cli-basics.md)

---

**Pro Tip:** Bookmark https://portal.azure.com for quick access. Consider using different browser profiles for different Azure subscriptions/tenants.
