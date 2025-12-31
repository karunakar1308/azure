# Migrating from GitHub to Azure DevOps

## Overview

This comprehensive guide covers the migration process from GitHub to Azure DevOps, including repositories, CI/CD pipelines, issues, and project management artifacts.

## Table of Contents

1. [Pre-Migration Assessment](#pre-migration-assessment)
2. [Migration Planning](#migration-planning)
3. [Repository Migration](#repository-migration)
4. [Pipeline Migration](#pipeline-migration)
5. [Issues and Work Items Migration](#issues-and-work-items-migration)
6. [User and Permission Migration](#user-and-permission-migration)
7. [Post-Migration Tasks](#post-migration-tasks)
8. [Best Practices](#best-practices)

---

## Pre-Migration Assessment

### What to Evaluate

- **Repository Count**: Number of repositories to migrate
- **Repository Size**: Large repositories may require special handling
- **Branch Structure**: Identify active and protected branches
- **CI/CD Pipelines**: GitHub Actions workflows to convert
- **Issues and PRs**: Open and closed items
- **Wiki Content**: Documentation to migrate
- **Team Size**: Number of users and their roles
- **Third-party Integrations**: External tools and services

### Key Differences Between GitHub and Azure DevOps

| Feature | GitHub | Azure DevOps |
|---------|--------|-------------|
| **Repository** | Git repositories | Azure Repos (Git or TFVC) |
| **CI/CD** | GitHub Actions | Azure Pipelines |
| **Issues** | GitHub Issues | Azure Boards (Work Items) |
| **Project Management** | GitHub Projects | Azure Boards |
| **Wiki** | GitHub Wiki | Azure Wiki |
| **Artifacts** | GitHub Packages | Azure Artifacts |

---

## Migration Planning

### Step 1: Create Azure DevOps Organization

1. Go to [dev.azure.com](https://dev.azure.com)
2. Sign in with your Microsoft account
3. Click **New Organization**
4. Choose organization name (e.g., `YourCompany-DevOps`)
5. Select region for data hosting

### Step 2: Create Project

1. Within your organization, click **New Project**
2. Enter project name
3. Choose visibility: **Private** or **Public**
4. Select version control: **Git** (recommended for GitHub migration)
5. Select work item process: **Agile**, **Scrum**, or **Basic**

### Step 3: Set Up Teams and Permissions

- Create teams matching your GitHub team structure
- Configure access levels (Basic, Stakeholder, Basic + Test Plans)
- Set up security groups

---

## Repository Migration

### Method 1: Using Azure DevOps Import

#### Prerequisites
- Azure DevOps project created
- GitHub repository URL
- GitHub personal access token (PAT) with `repo` scope

#### Steps

1. **Navigate to Azure Repos**
   - Go to your Azure DevOps project
   - Click **Repos** in left sidebar

2. **Import Repository**
   ```
   - Click repository dropdown at top
   - Select "Import repository"
   - Choose "Git" as source type
   ```

3. **Configure Import**
   - **Clone URL**: `https://github.com/username/repository.git`
   - **Name**: Repository name in Azure DevOps
   - **Authentication**: Enter GitHub username and PAT
   - Check "Requires Authorization" if private repo
   - Click **Import**

4. **Verify Migration**
   - Check all branches migrated
   - Verify commit history preserved
   - Confirm tags are present

### Method 2: Using Git Command Line

```bash
# Clone from GitHub (bare clone)
git clone --bare https://github.com/username/repo.git
cd repo.git

# Push to Azure DevOps
git push --mirror https://dev.azure.com/organization/project/_git/repo

# Clean up
cd ..
rm -rf repo.git
```

### Method 3: Using Azure DevOps Migration Tools

For complex migrations with multiple repositories:

```bash
# Install Azure DevOps Migration Tools
dotnet tool install -g vsts-sync-migrator

# Configure and run migration
# Create configuration.json with source and target details
migration-tools execute --config configuration.json
```

### Post-Repository Migration Checklist

- ✅ All branches migrated
- ✅ Tags preserved
- ✅ Commit history intact
- ✅ Branch policies configured
- ✅ Default branch set correctly
- ✅ Repository permissions configured

---

## Pipeline Migration

### GitHub Actions vs Azure Pipelines

#### Key Concepts Mapping

| GitHub Actions | Azure Pipelines |
|----------------|-----------------|
| Workflow | Pipeline |
| Job | Job/Stage |
| Step | Task/Script |
| `runs-on` | `pool` |
| `uses` (actions) | `task` |
| `env` | `variables` |
| Secrets | Variable Groups/Key Vault |
| Matrix builds | `strategy: matrix` |

### Converting GitHub Actions to Azure Pipelines

#### Example: GitHub Actions Workflow

```yaml
name: CI
on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Set up Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
    - run: npm install
    - run: npm test
    - run: npm run build
```

#### Equivalent Azure Pipeline

```yaml
trigger:
  branches:
    include:
    - main

pr:
  branches:
    include:
    - main

pool:
  vmImage: 'ubuntu-latest'

steps:
- checkout: self

- task: NodeTool@0
  inputs:
    versionSpec: '18.x'
  displayName: 'Install Node.js'

- script: npm install
  displayName: 'npm install'

- script: npm test
  displayName: 'Run tests'

- script: npm run build
  displayName: 'Build project'
```

### Migration Steps for Pipelines

1. **Analyze Existing Workflows**
   - Document all GitHub Actions workflows
   - Identify custom actions and third-party actions
   - Note environment variables and secrets

2. **Create Azure Pipeline YAML**
   - Navigate to Pipelines in Azure DevOps
   - Click **New Pipeline**
   - Select **Azure Repos Git** or **GitHub** (if keeping code on GitHub)
   - Choose **Starter pipeline** or existing template

3. **Convert Workflow Syntax**
   - Use the mapping table above
   - Replace GitHub-specific actions with Azure tasks
   - Configure service connections for external resources

4. **Set Up Variables and Secrets**
   - Create Variable Groups for shared variables
   - Link Azure Key Vault for secrets
   - Configure pipeline variables

5. **Test Pipeline**
   - Run pipeline manually
   - Verify all steps execute correctly
   - Check artifacts and test results

### Common Task Conversions

#### Docker Build and Push

**GitHub Actions:**
```yaml
- name: Build and push Docker image
  uses: docker/build-push-action@v4
  with:
    push: true
    tags: user/app:latest
```

**Azure Pipelines:**
```yaml
- task: Docker@2
  inputs:
    command: buildAndPush
    repository: user/app
    tags: latest
```

---

## Issues and Work Items Migration

### Understanding the Difference

- **GitHub Issues**: Simple issue tracking
- **Azure Boards**: Comprehensive work item tracking with multiple types (Epic, Feature, User Story, Task, Bug)

### Migration Approaches

#### Option 1: Manual Migration (Small Projects)

For projects with fewer than 50 issues:

1. Export GitHub issues (use GitHub API or export tool)
2. Create corresponding work items in Azure Boards
3. Add labels, assignees, and comments manually

#### Option 2: Using Azure DevOps Integration (Recommended)

**GitHub to Azure Boards Connection:**

1. In Azure Boards, go to **Project Settings** > **GitHub connections**
2. Click **Connect to GitHub**
3. Authenticate and select repositories
4. Configure link settings
5. Map GitHub labels to Azure Boards work item types

This creates:
- Links from Azure Boards work items to GitHub commits/PRs
- Automatic updates when PRs are created/merged

#### Option 3: Using Migration Tools

**Using node-gh-2-ado CLI tool:**

```bash
# Install tool
npm install -g node-gh-2-ado

# Export GitHub issues
gh-2-ado export --repo owner/repo --token GITHUB_TOKEN

# Import to Azure DevOps
gh-2-ado import --org MyOrg --project MyProject --pat ADO_PAT
```

### Work Item Mapping Strategy

| GitHub Issue Type | Azure Boards Work Item |
|-------------------|------------------------|
| Issue (bug label) | Bug |
| Issue (enhancement) | User Story/Feature |
| Issue (generic) | Task |
| Milestone | Epic/Feature |

---

## User and Permission Migration

### User Management

1. **Add Users to Azure DevOps**
   - Go to Organization Settings > Users
   - Click **Add users**
   - Enter email addresses
   - Assign access level

2. **Map GitHub Teams to Azure DevOps Teams**
   - Create teams in Project Settings > Teams
   - Assign team members
   - Configure team areas and iterations

### Permission Mapping

| GitHub Permission | Azure DevOps Access Level |
|-------------------|---------------------------|
| Read | Stakeholder (free) |
| Triage | Basic |
| Write | Basic |
| Maintain | Basic + Project Admin |
| Admin | Project Collection Admin |

### Repository Permissions

**GitHub:**
- Admin, Write, Read

**Azure DevOps (more granular):**
- Read, Contribute, Create Branch, Force Push, Manage Permissions
- Set at repository, branch, or tag level

---

## Post-Migration Tasks

### 1. Update Documentation

- Update README with new repository URLs
- Update CI/CD badge links
- Change documentation links from GitHub to Azure DevOps
- Update wiki content

### 2. Configure Branch Policies

```yaml
# Azure DevOps branch policies (configured via UI):
- Require pull request reviews (minimum reviewers)
- Require build validation (link pipelines)
- Require linked work items
- Auto-complete options
- Comment resolution requirements
```

### 3. Set Up Notifications

- Configure notification rules in user settings
- Set up team notifications
- Configure service hooks for Slack, Teams, etc.

### 4. Migrate Webhooks

**GitHub Webhooks → Azure DevOps Service Hooks**

1. Go to Project Settings > Service Hooks
2. Add new service hook
3. Select service (Web Hooks, Teams, Slack, etc.)
4. Configure trigger events
5. Test and activate

### 5. Archive or Redirect GitHub Repository

Options:

- **Archive**: Mark repository as archived in GitHub settings
- **Add README notice**: Add migration notice with new Azure DevOps URL
- **Keep synchronized**: Use Azure Boards GitHub integration to keep both in sync
- **Complete migration**: Delete GitHub repository (after verification period)

---

## Best Practices

### During Migration

✅ **DO:**

- Communicate migration plan to all team members
- Perform migration during low-activity periods
- Test migration process with a pilot repository first
- Document all custom configurations and integrations
- Keep GitHub repository active during transition period
- Verify all data migrated successfully before decommissioning
- Update all external links and references
- Train team on Azure DevOps interface and workflows

❌ **DON'T:**

- Rush the migration without proper planning
- Migrate without backing up important data
- Delete GitHub resources immediately after migration
- Forget to migrate secrets and environment variables
- Ignore branch protection rules
- Overlook third-party integrations

### Migration Timeline Recommendation

```
Week 1: Planning and Assessment
- Inventory all repositories, workflows, and integrations
- Create Azure DevOps organization and projects
- Design team and permission structure

Week 2: Pilot Migration
- Migrate one small repository as proof of concept
- Test repository access and permissions
- Convert and test one pipeline
- Gather feedback from pilot team

Week 3-4: Full Migration
- Migrate all repositories (prioritize by importance)
- Convert all pipelines
- Migrate issues and work items
- Set up notifications and service hooks

Week 5: Verification and Training
- Verify all migrations successful
- Conduct team training sessions
- Update documentation
- Monitor for issues

Week 6+: Decommission GitHub
- Archive or delete GitHub repositories
- Cancel GitHub subscription (if applicable)
- Monitor Azure DevOps for issues
```

### Security Considerations

1. **Secrets Management**
   - Never commit secrets to repositories
   - Use Azure Key Vault for sensitive data
   - Rotate all secrets during migration
   - Review and update service principal permissions

2. **Access Control**
   - Implement least privilege access
   - Enable multi-factor authentication (MFA)
   - Regular audit of user permissions
   - Use Azure AD integration for SSO

3. **Branch Protection**
   - Configure branch policies on main/master
   - Require code reviews
   - Require successful builds before merge
   - Enable auto-linking to work items

---

## Useful Tools and Resources

### Migration Tools

- **Azure DevOps Migration Tools**: Open-source tooling for bulk migrations
  - GitHub: `nkdAgility/azure-devops-migration-tools`
  
- **node-gh-2-ado**: Node.js tool for GitHub to Azure DevOps migration
  - npm: `node-gh-2-ado`

- **Git-TFS**: Tool for migrating from TFS to Git

### Documentation Links

- [Azure DevOps Documentation](https://docs.microsoft.com/azure/devops/)
- [Azure Repos Git Tutorial](https://docs.microsoft.com/azure/devops/repos/git/)
- [Azure Pipelines YAML Schema](https://docs.microsoft.com/azure/devops/pipelines/yaml-schema)
- [GitHub to Azure Boards Integration](https://docs.microsoft.com/azure/devops/boards/github/)

### Helpful Commands

#### Create Azure DevOps PAT (Personal Access Token)
```bash
# Via Azure DevOps Portal:
1. User Settings (top right) > Personal access tokens
2. Click "New Token"
3. Set scopes: Code (Read, Write), Build (Read & execute), etc.
4. Copy token (shown only once)
```

#### Clone Azure Repos Repository
```bash
# HTTPS
git clone https://dev.azure.com/organization/project/_git/repository

# SSH
git clone git@ssh.dev.azure.com:v3/organization/project/repository
```

#### Configure Git Credentials for Azure DevOps
```bash
# Install Git Credential Manager
git credential-manager configure

# Or use PAT directly
git clone https://PAT@dev.azure.com/organization/project/_git/repository
```

---

## Common Issues and Troubleshooting

### Issue: Large Repository Migration Fails

**Problem**: Repository over 10GB fails to import

**Solution**:
1. Use Git command line with `--mirror` flag
2. Consider using Git LFS for large files
3. Clean up repository history if needed:
   ```bash
   git filter-repo --strip-blobs-bigger-than 100M
   ```

### Issue: Pipeline Tasks Not Found

**Problem**: GitHub Actions have no direct Azure equivalent

**Solution**:
- Use script tasks with same commands
- Find marketplace extensions
- Create custom tasks if needed

### Issue: Secrets Not Working

**Problem**: Pipeline can't access secrets from GitHub

**Solution**:
1. Create Variable Groups in Azure Pipelines
2. Link to Azure Key Vault
3. Reference in pipeline:
   ```yaml
   variables:
   - group: my-variable-group
   ```

---

## Conclusion

Migrating from GitHub to Azure DevOps requires careful planning and execution. Key takeaways:

1. **Plan Thoroughly**: Assess all assets before starting
2. **Test First**: Use pilot repositories to validate approach
3. **Communicate**: Keep team informed throughout process
4. **Verify Everything**: Double-check data integrity after migration
5. **Train Your Team**: Ensure everyone understands new tools
6. **Don't Rush**: Allow adequate time for each phase

Azure DevOps provides a comprehensive DevOps platform with tight integration across the development lifecycle. While the migration requires effort, the benefits of unified tooling, enhanced security, and enterprise features make it worthwhile for many organizations.

---

## Quick Reference Checklist

### Pre-Migration
- [ ] Inventory all repositories
- [ ] Document workflows and integrations
- [ ] Create Azure DevOps organization
- [ ] Set up projects and teams
- [ ] Plan permission structure

### Migration
- [ ] Migrate repositories (with history)
- [ ] Convert GitHub Actions to Azure Pipelines
- [ ] Migrate issues to Azure Boards
- [ ] Set up branch policies
- [ ] Configure notifications
- [ ] Migrate secrets and variables
- [ ] Set up service connections

### Post-Migration
- [ ] Verify all data migrated
- [ ] Test pipelines
- [ ] Update documentation
- [ ] Train team members
- [ ] Monitor for issues
- [ ] Archive/redirect GitHub repositories

### Ongoing
- [ ] Regular permission audits
- [ ] Pipeline optimization
- [ ] Team feedback collection
- [ ] Documentation updates

---

**Last Updated**: December 2025

**Contributors**: For questions or improvements to this guide, please create a work item in Azure Boards.
