# Azure Policies for Azure Storage

Azure Policies are the tool in Azure to enforce a secure configuration of Azure Key Vault across specific management group scopes. The list below covers the recommended policies across various security layers:
- [Logging and Monitoring](#logging-and-monitoring)
- [Network Connectivity](#network-connectivity)
- [Encryption](#encryption)
- [Authentication](#authentication)

## Logging and Monitoring

The following Policies are recommended to be applied for a compliant logging and monitoring configuration:

| Purpose                                           | Built-in Policy | Custom Policy | Comment |
|:--------------------------------------------------|:----------------|:--------------|:--------| - |  |
| Diagnostics for Key Vault | [951af2fa-529b-416e-ab6e-066fd85ac459](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F951af2fa-529b-416e-ab6e-066fd85ac459) | - |  |

## Network Connectivity

The following Policies are recommended to be applied for a compliant network configuration:

| Purpose                                | Built-in Policy | Custom Policy | Comment |
|:---------------------------------------|:----------------|:--------------|:--------|
| Disabled Public Network Access | [405c5871-3e91-4644-8a63-58e19d68ff5b](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F405c5871-3e91-4644-8a63-58e19d68ff5b) | - |  |
| Default action Deny | [ac673a9a-f77d-4846-b2d8-a57f8e1c01dc](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fac673a9a-f77d-4846-b2d8-a57f8e1c01dc) | - |  |

## Encryption

The following Policies are recommended to be applied for a compliant encryption configuration:

| Purpose                                              | Built-in Policy | Custom Policy | Comment |
|:-----------------------------------------------------|:----------------|:--------------|:--------|
| - | - | - | - |

## Authentication

The following Policies are recommended to be applied for a compliant authentication configuration:

| Purpose                                 | Built-in Policy | Custom Policy | Comment |
|:----------------------------------------|:----------------|:--------------|:--------|
| Azure RBAC authorization | [12d4fa5e-1f9f-4c21-97a9-b99b3c6611b5](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F12d4fa5e-1f9f-4c21-97a9-b99b3c6611b5) | - |  |

## Other

The following additional Policies are recommended for a compliant configuration:

| Purpose                                 | Built-in Policy | Custom Policy | Comment |
|:----------------------------------------|:----------------|:--------------|:--------|
| Purge protection | [0b60c0b2-2dc2-4e1c-b5c9-abbed971de53](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F0b60c0b2-2dc2-4e1c-b5c9-abbed971de53) | - |  |
| Soft-delete | [1e66c121-a66a-4b1f-9b83-0fd99bf0fc2d](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F1e66c121-a66a-4b1f-9b83-0fd99bf0fc2d) | - |  |
| Maximum validity for certificates | [0a075868-4c26-42ef-914c-5bc007359560](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F0a075868-4c26-42ef-914c-5bc007359560) | - |  |
| Allowed key types for certificates | [1151cede-290b-4ba0-8b38-0ad145ac888f](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F1151cede-290b-4ba0-8b38-0ad145ac888f) | - |  |
| Lifetime actions for certificates | [12ef42cb-9903-4e39-9c26-422d29570417](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F12ef42cb-9903-4e39-9c26-422d29570417) | - |  |
| Issuer authority for certificates | [8e826246-c976-48f6-b03e-619bb92b3d82](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F8e826246-c976-48f6-b03e-619bb92b3d82) or [a22f4a40-01d3-4c7d-8071-da157eeff341](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fa22f4a40-01d3-4c7d-8071-da157eeff341) | - |  |
| Elliptic curve names | [bd78111f-4953-4367-9fd5-7e08808b54bf](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fbd78111f-4953-4367-9fd5-7e08808b54bf) | - |  |
| Expiration date for keys | [152b15f7-8e1f-4c1f-ab71-8c010ba5dbc0](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F152b15f7-8e1f-4c1f-ab71-8c010ba5dbc0) | - |  |
| Days before expiry for keys | [5ff38825-c5d8-47c5-b70e-069a21955146](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F5ff38825-c5d8-47c5-b70e-069a21955146) | - |  |
| Maximum validity for keys | [49a22571-d204-4c91-a7b6-09b1a586fbc9](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F49a22571-d204-4c91-a7b6-09b1a586fbc9) | - |  |
| Cryptographic type for keys | [75c4f823-d65c-4f29-a733-01d0077fdbcb](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F75c4f823-d65c-4f29-a733-01d0077fdbcb) | - |  |
| RSA key size | [82067dbb-e53b-4e06-b631-546d197452d9](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F82067dbb-e53b-4e06-b631-546d197452d9) | - |  |
| Maximum validity for secrets | [342e8053-e12e-4c44-be01-c3c2f318400f](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F342e8053-e12e-4c44-be01-c3c2f318400f) | - |  |
| Expiration date for secrets | [98728c90-32c7-4049-8429-847dc0f4fe37](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F98728c90-32c7-4049-8429-847dc0f4fe37) | - |  |
| Content type for secrets | [75262d3e-ba4a-4f43-85f8-9f72c090e5e3](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F75262d3e-ba4a-4f43-85f8-9f72c090e5e3) | - |  |
| Days before expiry for secrets | [b0eb591a-5e70-4534-a8bf-04b9c489584a](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fb0eb591a-5e70-4534-a8bf-04b9c489584a) | - |  |
