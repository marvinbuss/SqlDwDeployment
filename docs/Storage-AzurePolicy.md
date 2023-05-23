# Azure Policies for Azure Storage

Azure Policies are the tool in Azure to enforce a secure configuration of Azure Storage across specific management group scopes. The list below covers the recommended policies across various security layers:
- [Logging and Monitoring](#logging-and-monitoring)
- [Network Connectivity](#network-connectivity)
- [Encryption](#encryption)
- [Authentication](#authentication)

## Logging and Monitoring

The following Policies are recommended to be applied for a compliant logging and monitoring configuration:

| Purpose                                           | Built-in Policy | Custom Policy | Comment |
|:--------------------------------------------------|:----------------|:--------------|:--------|
| Diagnostics for Storage account | [59759c62-9a22-4cdf-ae64-074495983fef](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F59759c62-9a22-4cdf-ae64-074495983fef) | - |  |
| Diagnostics for Storage File Services | [25a70cc8-2bd4-47f1-90b6-1478e4662c96](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F25a70cc8-2bd4-47f1-90b6-1478e4662c96) | - |  |
| Diagnostics for Storage Table Services | [2fb86bf3-d221-43d1-96d1-2434af34eaa0](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F2fb86bf3-d221-43d1-96d1-2434af34eaa0) | - |  |
| Diagnostics for Storage Blob Services | [b4fe1a3b-0715-4c6c-a5ea-ffc33cf823cb](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fb4fe1a3b-0715-4c6c-a5ea-ffc33cf823cb) | - |  |
| Diagnostics for Storage Queue Services | [7bd000e3-37c7-4928-9f31-86c4b77c5c45](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F7bd000e3-37c7-4928-9f31-86c4b77c5c45) | - |  |
|  |  |  |  |

## Network Connectivity

The following Policies are recommended to be applied for a compliant network configuration:

| Purpose                                | Built-in Policy | Custom Policy | Comment |
|:---------------------------------------|:----------------|:--------------|:--------|
| ~~Disabled public network access~~ | ~~[a06d0189-92e8-4dba-b0c4-08d7669fce7d](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fa06d0189-92e8-4dba-b0c4-08d7669fce7d) and [b2982f36-99f2-4db5-8eff-283140c09693](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fb2982f36-99f2-4db5-8eff-283140c09693)~~ | - | Many native Azure Services do not work with public network access disabled. Resource instance rules or trusted Microsoft Services must be enabled to allow communication. |
| No IP Firewall Rules | [2a1a9cdf-e04d-429a-8416-3bfb72a1b26f](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F2a1a9cdf-e04d-429a-8416-3bfb72a1b26f) |  |  |
| Default action Deny | [34c877ad-507e-4c82-993e-3452a6e0ad3c](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F34c877ad-507e-4c82-993e-3452a6e0ad3c) |  |  |
| Restrict Network ACL bypass option | - | [Deny-NetworkAclsBypass-Storage](/docs/AzurePolicies/Deny-NetworkAclsBypass-Storage.json) |  |
| No virtual network firewall rules | - | [Deny-NetworkAclsVirtualNetworkRules-Storage](/docs/AzurePolicies/Deny-NetworkAclsVirtualNetworkRules-Storage.json) |  |
| Restrict resource access tenant IDs | - | [Deny-ResourceAccessRulesTenantId-Storage](/docs/AzurePolicies/Deny-ResourceAccessRulesTenantId-Storage.json) |  |
| Restrict resource access resource IDs | - | [Deny-ResourceAccessRulesResourceId-Storage](/docs/AzurePolicies/Deny-ResourceAccessRulesResourceId-Storage.json) |  |
| Restrict CORS rules | - | [Deny-CORS-Storage](/docs/AzurePolicies/Deny-CORS-Storage.json) | Must be lifted for Azure Databricks with Unity. |

## Encryption

The following Policies are recommended to be applied for a compliant encryption configuration:

| Purpose                                              | Built-in Policy | Custom Policy | Comment |
|:-----------------------------------------------------|:----------------|:--------------|:--------|
| ~~Customer-managed key~~ | - | ~~[Deny-CustomerManagedKey-Storage](/docs/AzurePolicies/Deny-CustomerManagedKey-Storage.json)~~ | Only required for specific scenarios. |
| ~~Customer-managed key for encryption scopes~~ | ~~[b5ec538c-daa0-4006-8596-35468b9148e8](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fb5ec538c-daa0-4006-8596-35468b9148e8)~~ | - | Only required for specific scenarios. |
| ~~Customer-managed key for Table services~~ | ~~[7c322315-e26d-4174-a99e-f49d351b4688](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F7c322315-e26d-4174-a99e-f49d351b4688)~~ | - | Only required for specific scenarios. |
| ~~Customer-managed key for Queue services~~ | ~~[f0e5abd0-2554-4736-b7c0-4ffef23475ef](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Ff0e5abd0-2554-4736-b7c0-4ffef23475ef)~~ | - | Only required for specific scenarios. |
| Storage account key expiry | [044985bb-afe1-42cd-8a36-9d5d42424537](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F044985bb-afe1-42cd-8a36-9d5d42424537) | - |  |
| HTTPS traffic only | [404c3081-a854-4457-ae30-26a93ef643f9](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F404c3081-a854-4457-ae30-26a93ef643f9) and [f81e3117-0093-4b17-8a60-82363134f0eb](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Ff81e3117-0093-4b17-8a60-82363134f0eb) | - |  |
| Infrastructure encryption | [4733ea7b-a883-42fe-8cac-97454c2a9e4a](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F4733ea7b-a883-42fe-8cac-97454c2a9e4a) | - |  |
| Infrastructure encryption for encryption scopes | [bfecdea6-31c4-4045-ad42-71b9dc87247d](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fbfecdea6-31c4-4045-ad42-71b9dc87247d) | - |  |
| TLS 1.2 enforcement | [fe83a0eb-a853-422d-aac2-1bffd182c5d0](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Ffe83a0eb-a853-422d-aac2-1bffd182c5d0) | - |  |

## Authentication

The following Policies are recommended to be applied for a compliant authentication configuration:

| Purpose                                 | Built-in Policy | Custom Policy | Comment |
|:----------------------------------------|:----------------|:--------------|:--------|
| No public access for blob | [4fa4b6c0-31ca-4c0d-b10d-24b96f62a751](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F4fa4b6c0-31ca-4c0d-b10d-24b96f62a751) and [13502221-8df0-4414-9937-de9c5c4e396b](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F13502221-8df0-4414-9937-de9c5c4e396b) |  |  |
| No key-based authentication | [8c6a50c6-9ffd-4ae7-986f-5fa6111f9a54](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F8c6a50c6-9ffd-4ae7-986f-5fa6111f9a54) |  |  |
| SAS policy enforced | [bc1b984e-ddae-40cc-801a-050a030e4fbe](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fbc1b984e-ddae-40cc-801a-050a030e4fbe) |  |  |
| ~~No local user enabled~~ | - | ~~[Deny-IsLocalUserEnabled-Storage](/docs/AzurePolicies/Deny-IsLocalUserEnabled-Storage.json)~~ | Policy exemption required for specific storage accounts. |
| ~~No SFTP enabled~~ | - | ~~[Deny-IsSftpEnabled-Storage](/docs/AzurePolicies/Deny-IsSftpEnabled-Storage.json)~~ | Policy exemption required for specific storage accounts. |

## Other

The following additional Policies are recommended for a compliant configuration:

| Purpose                                 | Built-in Policy | Custom Policy | Comment |
|:----------------------------------------|:----------------|:--------------|:--------|
| No classic storage accounts | [37e0d2fe-28a5-43d6-a273-67d37d1f5606](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F37e0d2fe-28a5-43d6-a273-67d37d1f5606) | - | Deny old classic storage accounts. |
| Enforce redundancy level | [7433c107-6db4-4ad1-b57a-a76dce0154a1](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F7433c107-6db4-4ad1-b57a-a76dce0154a1) | - | Required for disaster recovery. |
| No cross-tenant data replication | [92a89a79-6c52-4a7e-a03f-61306fc49312](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F92a89a79-6c52-4a7e-a03f-61306fc49312) | - |  |
| Limit allowed copy scope | - | [Deny-AllowedCopyScope-Storage](/docs/AzurePolicies/Deny-AllowedCopyScope-Storage.json) |  |
| Container retention policy | - | [Deny-ContainerDeleteRetentionPolicy-Storage](/docs/AzurePolicies/Deny-ContainerDeleteRetentionPolicy-Storage.json) |  |
