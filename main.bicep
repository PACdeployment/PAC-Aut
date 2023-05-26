targetScope = 'subscription'

// PARAMETERS - DO NOT MODIFY
param policySource string = 'globalbao/azure-policy-as-code'
param policyCategory string = 'Custom'
param assignmentEnforcementMode string
param assignmentIdentityLocation string
param mandatoryTag1Key string
param mandatoryTag1Value string
param nonComplianceMessageContactEmail string
param listOfAllowedLocations array
param listOfAllowedSKUs array

module polDefinitions './polDefinitions.bicep' = {
  name: 'polDefinitions'
  params: {
    policySource: policySource
    policyCategory: policyCategory
    mandatoryTag1Key: mandatoryTag1Key
    mandatoryTag1Value: mandatoryTag1Value
  }
}

module polInitiatives './polInitiatives.bicep' = {
  name: 'polInitiatives'
  params: {
    policySource: policySource
    policyCategory: policyCategory
    mandatoryTag1Key: mandatoryTag1Key
    mandatoryTag1Value: mandatoryTag1Value
   customPolicyID: polDefinitions.outputs.policyID
  
  }
}
module polAssignments './polAssignments.bicep' = {
  name: 'polAssignments'
  params: {
    policySource: policySource
    assignmentEnforcementMode: assignmentEnforcementMode
    assignmentIdentityLocation: assignmentIdentityLocation
    mandatoryTag1Key: mandatoryTag1Key
    mandatoryTag1Value: mandatoryTag1Value
    nonComplianceMessageContactEmail: nonComplianceMessageContactEmail
    listOfAllowedLocations: listOfAllowedLocations
    listOfAllowedSKUs: listOfAllowedSKUs
    initiative1ID: polInitiatives.outputs.initiative1ID
    initiative2ID: polInitiatives.outputs.initiative2ID
  }}
