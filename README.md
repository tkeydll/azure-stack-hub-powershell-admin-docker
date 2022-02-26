# azure-stack-hub-powershell-admin-docker
Powershell docker image for Azure Stack Hub Admin.


## Build image

``` bash
docker build -t tkeydll/azure-stack-hub-powershell-admin-docker:latest . \
--build-arg ca_cert_url=<your_cert_url> \
--build-arg endpoint_resource_manager=<your_admin_arm_endpoint> \
--build-arg suffix_keyvault_dns=<your_keyvault_suffix> \
--build-arg tenant_name=<your_tenant_name>.onmicrosoft.com
```


## Connect Azure Stack Hub

First, connect to Azure Stack Hub with the following command.

```powershell
Connect-AzAccount -EnvironmentName AzureStackAdmin -TenantId <your_tenant_id> -UseDeviceAuthentication
```
