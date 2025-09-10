param functionAppName string
param location string = resourceGroup().location

param environmentName string = 'dev'

var resourceToken = toLower(uniqueString(subscription().id, environmentName, location))

resource storageAccount 'Microsoft.Storage/storageAccounts@2025-01-01' = {
  name: 'st${resourceToken}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'

  properties: {
    allowSharedKeyAccess: true
    isLocalUserEnabled: true
    publicNetworkAccess: 'Enabled'
  }
}

resource functionApp 'Microsoft.Web/sites@2022-09-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp,linux'
  properties: {
    serverFarmId: consumptionPlan.id
    siteConfig: {
    linuxFxVersion: 'PYTHON|3.11'
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};AccountKey=${storageAccount.listKeys().keys[0].value};EndpointSuffix=core.windows.net'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'python'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4' 
        }        
      ]
    }
  }
}

resource consumptionPlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: '${functionAppName}-plan'
  location: location
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
  }
  properties: {
    isSpot: false
    reserved: true // Required for Linux
  }
  kind: 'functionapp'
}

output functionAppName string = functionApp.name
