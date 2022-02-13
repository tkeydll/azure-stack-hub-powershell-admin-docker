FROM mcr.microsoft.com/azurestack/powershell:latest

ARG ca_cert_url
ARG environment_name=AzureStackAdmin
ARG endpoint_resource_manager=https://adminmanagement.local.azurestack.external
ARG suffix_keyvault_dns=.adminvault.local.azurestack.external
ARG tenant_name=your_tenant_name

# Add cacert.
WORKDIR /usr/local/share/ca-certificates
RUN wget -O azurestackhub.crt ${ca_cert_url}
RUN update-ca-certificates

# Register an Azure Resource Manager environment that targets your Azure Stack Hub instance. Get your Azure Resource Manager endpoint value from your service provider.
RUN Add-AzEnvironment -Name $environment_name -ArmEndpoint $endpoint_resource_manager -AzureKeyVaultDnsSuffix $suffix_keyvault_dns -AzureKeyVaultServiceEndpointResourceId $suffix_keyvault_dns
RUN Set-AzEnvironment -Name $environment_name

# Set your tenant name.
RUN $AuthEndpoint = (Get-AzEnvironment -Name $environment_name).ActiveDirectoryAuthority.TrimEnd('/')
RUN $AADTenantName = $your_tenant_name
RUN $TenantId = (invoke-restmethod "$($AuthEndpoint)/$($AADTenantName)/.well-known/openid-configuration").issuer.TrimEnd('/').Split('/')[-1]


#Connect-AzAccount -EnvironmentName "AzureStackAdmin" -TenantId $TenantId -UseDeviceAuthentication
