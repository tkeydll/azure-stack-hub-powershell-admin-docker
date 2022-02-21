FROM mcr.microsoft.com/azurestack/powershell:latest

ARG ca_cert_url
ARG environment_name=AzureStackAdmin
ARG endpoint_resource_manager=https://adminmanagement.local.azurestack.external
ARG suffix_keyvault_dns=.adminvault.local.azurestack.external
ARG tenant_name=your_tenant_name
ARG tenant_id

# Add cacert.
WORKDIR /usr/local/share/ca-certificates
RUN Invoke-WebRequest -Uri $Env:ca_cert_url -OutFile azurestackhub.crt && update-ca-certificates

# Register an Azure Resource Manager environment that targets your Azure Stack Hub instance. Get your Azure Resource Manager endpoint value from your service provider.
WORKDIR /root
RUN Add-AzEnvironment -Name $Env:environment_name -ArmEndpoint $Env:endpoint_resource_manager -AzureKeyVaultDnsSuffix $Env:suffix_keyvault_dns -AzureKeyVaultServiceEndpointResourceId $Env:suffix_keyvault_dns
RUN Set-AzEnvironment -Name $Env:environment_name

# Set your tenant name.
#RUN $AuthEndpoint = (Get-AzEnvironment -Name $Env:environment_name).ActiveDirectoryAuthority.TrimEnd('/')
#RUN $AADTenantName = $Env:tenant_name
#RUN $TenantId = (Invoke-RestMethod "$($AuthEndpoint)/$($AADTenantName)/.well-known/openid-configuration").issuer.TrimEnd('/').Split('/')[-1]

# Connect Azure Stack Hub.
#RUN Connect-AzAccount -EnvironmentName $Env:environment_name -TenantId $TenantId -UseDeviceAuthentication
