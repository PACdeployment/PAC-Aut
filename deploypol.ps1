connect-azaccount -Tenant "0878652c-d29e-4662-9fff-bcd7e301ec23"

# get Context and set the context for the deployment
$context = get-azsubscription -SubscriptionId "d4a23241-7c83-4708-a2ce-c5c15fd80a35"
set-azcontext $context 
##  "appRoleIndex": { 
 # "saAccountCounts
# prcreaet main resource group if needed
## ### New-AzResourceGroup -name 'rrr' -location 'location' -force

# splat expresssion to assign parameters for deployment 
$Parameters = @{
    Name = "deploymentName"+ (get-date).ToString("yyyyMMddHHmmss")
    TemplateFile = "main.bicep"
    TemplateParameterFile = "./param-dev-pol.json"
 
}




New-AzSubscriptionDeployment @parameters -verbose  -Location "westus2" 
