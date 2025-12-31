# Azure Kubernetes Service (AKS)

## Overview

Azure Kubernetes Service (AKS) is a managed container orchestration service that simplifies the deployment, management, and operations of Kubernetes clusters in Azure. AKS reduces the complexity and operational overhead of managing Kubernetes by offloading much of that responsibility to Azure, including health monitoring and maintenance.

## Key Features

- Fully managed Kubernetes control plane (Azure handles upgrades, patches, and availability)
- Auto-scaling with Horizontal Pod Autoscaler (HPA) and Cluster Autoscaler
- Integrated Azure Active Directory and role-based access control (RBAC)
- Integration with Azure DevOps and CI/CD pipelines
- Built-in monitoring with Azure Monitor and Container Insights
- Multiple node pool support with different VM sizes
- Azure Virtual Network (VNet) integration and Azure CNI networking
- Support for Windows and Linux containers

## Getting Started

### Prerequisites

- Azure subscription
- Azure CLI installed
- Basic understanding of container orchestration and Kubernetes concepts
- kubectl command-line tool

### Quick Setup

```bash
# Example: Create an AKS cluster
az aks create \
  --resource-group myResourceGroup \
  --name myAKSCluster \
  --node-count 3 \
  --enable-addons monitoring \
  --generate-ssh-keys

# Get credentials to connect to the cluster
az aks get-credentials --resource-group myResourceGroup --name myAKSCluster

# Verify connection
kubectl get nodes
```

## Common Operations

### Create Resource

```bash
# Create AKS cluster with specific Kubernetes version
az aks create \
  --resource-group myResourceGroup \
  --name myAKSCluster \
  --kubernetes-version 1.27.7 \
  --node-count 3 \
  --node-vm-size Standard_DS2_v2
```

### Configure Resource

```bash
# Scale the cluster
az aks scale --resource-group myResourceGroup --name myAKSCluster --node-count 5

# Upgrade Kubernetes version
az aks upgrade --resource-group myResourceGroup --name myAKSCluster --kubernetes-version 1.28.0

# Enable cluster autoscaler
az aks update \
  --resource-group myResourceGroup \
  --name myAKSCluster \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 5
```

### Monitor Resource

```bash
# View cluster details
az aks show --resource-group myResourceGroup --name myAKSCluster

# Get cluster logs
az aks get-credentials --resource-group myResourceGroup --name myAKSCluster
kubectl get pods --all-namespaces
kubectl logs <pod-name> -n <namespace>

# Check node status
kubectl get nodes
kubectl describe node <node-name>
```

## Azure DevOps Integration

AKS integrates seamlessly with Azure DevOps for continuous integration and deployment:

```yaml
# Example Azure DevOps pipeline for AKS deployment
trigger:
- main

pool:
  vmImage: 'ubuntu-latest'

variables:
  azureSubscription: 'your-service-connection'
  resourceGroup: 'myResourceGroup'
  aksCluster: 'myAKSCluster'
  containerRegistry: 'myacr.azurecr.io'

stages:
- stage: Build
  jobs:
  - job: BuildAndPush
    steps:
    - task: Docker@2
      inputs:
        containerRegistry: '$(containerRegistry)'
        repository: 'myapp'
        command: 'buildAndPush'
        Dockerfile: '**/Dockerfile'

- stage: Deploy
  jobs:
  - job: DeployToAKS
    steps:
    - task: KubernetesManifest@0
      inputs:
        action: 'deploy'
        kubernetesServiceConnection: '$(azureSubscription)'
        namespace: 'default'
        manifests: 'k8s/*.yaml'
```

## Best Practices

### ✅ DO:

- Use managed identities for secure authentication
- Enable Azure Policy for Kubernetes for governance
- Implement network policies to secure pod-to-pod communication
- Use Azure Container Registry (ACR) for private container images
- Enable Azure Monitor and Container Insights for observability
- Implement resource quotas and limits for namespaces
- Use separate node pools for different workload types
- Regularly update AKS cluster and node images

### ❌ DON'T:

- Don't run production workloads without resource limits
- Avoid using the default namespace for production applications
- Don't expose Kubernetes API server publicly without proper security
- Avoid hardcoding secrets in manifests - use Azure Key Vault
- Don't skip cluster upgrades - stay within supported versions

## Pricing Considerations

- AKS control plane is free - you only pay for the worker nodes (VMs)
- Node VM costs based on selected VM size and region
- Additional costs for Azure Load Balancer, Public IPs, and storage
- Azure Monitor and Log Analytics have separate pricing
- Cost optimization: Use spot instances for non-critical workloads, enable cluster autoscaler
- Free tier available for development/testing with limitations

## Common Use Cases

1. **Microservices Architecture**: Deploy and manage containerized microservices with service discovery and load balancing
2. **CI/CD Pipelines**: Integrate with Azure DevOps, GitHub Actions, or Jenkins for automated deployments
3. **Batch Processing**: Run batch jobs and parallel workloads using Kubernetes Jobs and CronJobs
4. **Machine Learning**: Deploy ML models and training workloads with GPU-enabled node pools
5. **Hybrid Cloud**: Connect AKS to on-premises infrastructure using Azure Arc

## Troubleshooting

### Issue 1: Pods Not Starting

**Problem**: Pods stuck in Pending or CrashLoopBackOff state

**Solution**:
- Check pod events: `kubectl describe pod <pod-name>`
- Verify resource requests don't exceed node capacity
- Check image pull secrets for private registries
- Review pod logs: `kubectl logs <pod-name>`
- Ensure node pools have sufficient capacity

### Issue 2: Network Connectivity Issues

**Problem**: Services cannot communicate or external access fails

**Solution**:
- Verify network policies aren't blocking traffic
- Check service and ingress configurations
- Ensure Network Security Groups (NSGs) allow required traffic
- Verify DNS resolution: `kubectl run -it --rm debug --image=busybox --restart=Never -- nslookup <service-name>`
- Check Azure CNI IP address exhaustion

## Next Steps

- [Azure Container Registry Integration](../azure-container-registry/)
- [Azure Monitor for Containers](../azure-monitor/)
- [Azure DevOps Integration](../07-azure-devops/)
- [Azure Key Vault Integration](../azure-key-vault/)

## Additional Resources

- [Official AKS Documentation](https://docs.microsoft.com/azure/aks/)
- [AKS Pricing Calculator](https://azure.microsoft.com/pricing/calculator/)
- [AKS Best Practices Guide](https://docs.microsoft.com/azure/aks/best-practices)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [AKS Roadmap and Updates](https://github.com/Azure/AKS/)
