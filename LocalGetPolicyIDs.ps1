Login-AzAccount
Get-AzureSubscription

$PoliciesFilePath = "C:\Lab-bicep\AZ-PAC\"
$PoliciesFilePath = "C:\Lab-bicep\AZ-PAC\"

# Create object to store policy IDs
[ScriptBlock]$PolicyNameResolverNoCategory = {
    $baseDisplayName = $PSItem.Properties.displayName -replace "[^\s\w]", ''
    $category =  $PSItem.Properties.metadata.category -replace '\s',''
    $name = (Get-Culture).TextInfo.ToTitleCase($baseDisplayName) -replace '\s',''
    $category + "-" + $name
}

[ScriptBlock]$PolicyNameResolverNoCategory = {
    $baseDisplayName = $PSItem.Properties.displayName -replace "[^\s\w]", ''
    $name = (Get-Culture).TextInfo.ToTitleCase($baseDisplayName) -replace '\s',''
    $name
}

# ALLPOlocies - query all poloicies in the subscription and build hashtable
$policies = Get-AzPolicyDefinition |
   Where-Object {$_.Properties.policyType -match 'BuiltIn' -and $_.Properties.metadata.deprecated  -ne 'True' -and $_.Properties.metadata.preview -ne 'True'} |
   Select-Object @{N='Name';E=$PolicyNameResolverWithCategory}, PolicyDefinitionId |
   Sort-Object Name |
   foreach-object {
   '"{0}": "{1}"' -f $_.Name, $_.PolicyDefinitionId
     }

     # All policies - Export all policies definition IDs to JSON
     ConvertTo-Json -InputObject $policies -Depth 10 | Out-File $PoliciesFilePath\all_policies.JSON
    
 $policySets = Get-AzPolicySetDefinition |
     Where-Object {$_.Properties.PolicyType -match 'BuiltIn' -and $_.Properties.metadata.deprecated  -ne 'True' -and $_.Properties.metadata.preview -ne 'True'} |
     Select-Object @{N='Name';E=$PolicyNameResolverNoCategory}, PolicySetDefinitionId |
     Sort-Object Name |
     foreach-object {
     '"{0}": "{1}"' -f $_.Name, $_.PolicySetDefinitionId
       }
# All policySets - Export all policySets definition IDs to JSON
       ConvertTo-Json -InputObject $policySets -Depth 10 | Out-File $PoliciesFilePath\all_policySets.JSON
  
    
# COMPUTE 1 -Query policy definition IDs and built hasntable 
$policies1 = Get-AzPolicyDefinition |
    Where-Object {$_.Properties.policyType -match 'BuiltIn' -and $_.Properties.metadata.category  -eq 'Compute' -and $_.Properties.metadata.deprecated -ne 'True' -and $_.Properties.metadata.preview -ne 'True'} |
    Select-Object @{N='Name';E=$PolicyNameResolverNoCategory}, PolicyDefinitionId |
    Sort-Object Name |
    foreach-object {
    '"{0}": "{1}"' -f $_.Name, $_.PolicyDefinitionId
      }
    
      # COMPUTE 1 - Export policy definition IDs to JSON
      ConvertTo-Json -InputObject $policies -Depth 10 | Out-File $PoliciesFilePath\compute_policies2.JSON