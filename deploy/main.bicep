//Based on https://www.youtube.com/watch?v=-LhlIqYr3JI
@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

@description('The type of environment. This must be nonprod or prod.')
@allowed([
    'nonprod'
])
param environmentType string

@description('A unique suffix to add to resource names that need to be globally unique.')
@maxLength(13)
param resourceNameSuffix string = uniqueString(resourceGroup().id)

var appServiceAppName = 'spring-boot-hello-world-${resourceNameSuffix}'
var appServicePlanName = 'spring-boot-hello-world-plan'
//var springBootHelloWorldStorageAccountName = 'springboothelloworld${resourceNameSuffix}'

param imageName string = 'ghcr.io/ntahan-code/springboothelloworld:latest'


var environmentConfigurationMap = {
    nonprod: {
        appServicePlan: {
            sku: {
                name: 'F1'
                capacity: 1
            }
        }
    }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
    name: appServicePlanName
    location: location
    sku: environmentConfigurationMap[environmentType].appServicePlan.sku
}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
    name: appServiceAppName
    location: location
    kind: 'app,linux,container'
    properties: {
        serverFarmId: appServicePlan.id
        siteConfig: {
            appSettings: [
                {
                    name: 'DOCKER_REGISTRY_SERVER_URL'
                    value: 'https://ghcr.io'
                }
                {
                    name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
                    value: 'false'
                }
            ]
            linuxFxVersion: 'DOCKER|${imageName}'
        }
        httpsOnly: true
    }
}