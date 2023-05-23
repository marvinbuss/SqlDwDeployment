# Azure Policies for Azure Synapse

Azure Policies are the tool in Azure to enforce a secure configuration of Azure Synapse across specific management group scopes. The list below covers the recommended policies across various security layers:
- [Logging and Monitoring](#logging-and-monitoring)
- [Network Connectivity](#network-connectivity)
- [Encryption](#encryption)
- [Authentication](#authentication)

## Logging and Monitoring

The following Policies are recommended to be applied for a compliant logging and monitoring configuration:

| Purpose                                           | Built-in Policy | Custom Policy | Comment |
|:--------------------------------------------------|:----------------|:--------------|:--------|
| Diagnostics for Synapse workspace                 | - | [Dine-Diagnostics-SynapseWorkspace](/docs/AzurePolicies/Dine-Diagnostics-SynapseWorkspace.json) | |
| Diagnostics for Synapse SQL Pool                  | - | [Dine-Diagnostics-SynapseSqlPool](/docs/AzurePolicies/Dine-Diagnostics-SynapseSqlPool.json) | |
| Diagnostics for Synapse Big Data Pool             | - | [Dine-Diagnostics-SynapseBigDataPool](/docs/AzurePolicies/Dine-Diagnostics-SynapseBigDataPool.json) | |
| Auditing Settings for Synapse Workspace           | - | [Dine-Auditing-SynapseWorkspace](/docs/AzurePolicies/Dine-Diagnostics-SynapseBigDataPool.json) | |
| Microsoft Defender for Cloud - SQL (Subscription) | [b99b73e7-074b-4089-9395-b7236f094491](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fb99b73e7-074b-4089-9395-b7236f094491) | - | |
| Security Alert Policies for Synapse workspace     | [951c1558-50a5-4ca3-abb6-a93e3e2367a6](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F951c1558-50a5-4ca3-abb6-a93e3e2367a6) | - | Gets enabled by "*Microsoft Defender for Cloud - SQL (Subscription)* Azure Defender for Cloud" |
| Vulnerability Assessments for Synapse SQL Pool    | - | [Dine-VulnerabilityAssessments-SynapseWorkspace](/docs/AzurePolicies/Dine-VulnerabilityAssessments-SynapseWorkspace.json) | |
| Logging for Synapse Spark Pools                   | - | [Deny-Logging-SynapseSpark](/docs/AzurePolicies/Deny-Logging-SynapseSpark.json) | |

## Network Connectivity

The following Policies are recommended to be applied for a compliant network configuration:

| Purpose                                | Built-in Policy | Custom Policy | Comment |
|:---------------------------------------|:----------------|:--------------|:--------|
| Tenant allow-listing                   | [3a003702-13d2-4679-941b-937e58c443f0](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F3a003702-13d2-4679-941b-937e58c443f0) | - | |
| Managed Virtual Network                | [2d9dbfa3-927b-4cf0-9d0f-08747f971650](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F2d9dbfa3-927b-4cf0-9d0f-08747f971650) | - | |
| No IP Firewall Rules                   | - | [Deny-Firewallrules-SynapseWorkspace](/docs/AzurePolicies/Deny-Firewallrules-SynapseWorkspace.json) |
| Disabled Public Network Access         | [38d8df46-cf4e-4073-8e03-48c24b29de0d](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F38d8df46-cf4e-4073-8e03-48c24b29de0d) | - | |
| Data Exfiltration Protection           | [3484ce98-c0c5-4c83-994b-c5ac24785218](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F3484ce98-c0c5-4c83-994b-c5ac24785218) | - | |
| Linked Access Check on Target Resource | - | [Deny-LinkedAccessCheckOnTargetResource-SynapseWorkspace](/docs/AzurePolicies/Deny-LinkedAccessCheckOnTargetResource-SynapseWorkspace.json) |
| Deny Trusted Services Bypass | - | [Deny-TrustedServiceBypassEnabled-SynapseWorkspace](/docs/AzurePolicies/Deny-TrustedServiceBypassEnabled-SynapseWorkspace.json) | |
| Private DNS Zone Group for all group IDs | [1e5ed725-f16c-478b-bd4b-7bfa2f7940b9](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F1e5ed725-f16c-478b-bd4b-7bfa2f7940b9) | - | Can be assigned with different parameters to cover all sub-resources. | |

## Encryption

The following Policies are recommended to be applied for a compliant encryption configuration:

| Purpose                                              | Built-in Policy | Custom Policy | Comment |
|:-----------------------------------------------------|:----------------|:--------------|:--------|
| ~~Customer-managed key for Synapse Workspace~~           | - | ~~[f7d52b2d-e161-4dfa-a82b-55e564167385](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Ff7d52b2d-e161-4dfa-a82b-55e564167385)~~ | Only required for specific scenarios. |
| TDE for Synapse SQL Pool                             | [Dine-TransparentDataEncryption-SynapseSqlPool](/docs/AzurePolicies/Dine-TransparentDataEncryption-SynapseSqlPool.json) | - | |
| Encryption in transit for Synapse SQL Pool (TLS 1.2) | - | [8b5c654c-fb07-471b-aa8f-15fea733f140](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F8b5c654c-fb07-471b-aa8f-15fea733f140) | |

## Authentication

The following Policies are recommended to be applied for a compliant authentication configuration:

| Purpose                                 | Built-in Policy | Custom Policy | Comment |
|:----------------------------------------|:----------------|:--------------|:--------|
| AAD-only Authentication | [2158ddbe-fefa-408e-b43f-d4faef8ff3b8](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F2158ddbe-fefa-408e-b43f-d4faef8ff3b8) and [c3624673-d2ff-48e0-b28c-5de1c6767c3c](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fc3624673-d2ff-48e0-b28c-5de1c6767c3c) | - | |
