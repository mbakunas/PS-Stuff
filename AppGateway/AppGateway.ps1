#Region parameters
$networkResourceGroupName = 'HubSpokeTest01'
$vnetName                 = 'Spoke-Prod-EastUS2-01'
$subnetName               = 'AppGW-10.0.8.0_24'

$appGWresourceGroupName   = 'AppGWTest02'
$location                 = 'eastus2'
$appGWname                = "$vnetName-AppGW-01"
$appGWpublicIPname        = "$appGWname-IP"

#EndRegion parameters

#region functions

# get the selected region's availability zones
$foo = Get-AzLocation | Where-Object {$_.Location -eq $location}

Get-AzComputeResourceSku | Where-Object {$_.Locations.Contains($location)}

#endregion functions

# appGW resource group
New-AzResourceGroup -Name $appGWresourceGroupName -Location $location -ErrorAction Continue -Force

#region Network
$vnetConfig = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $networkResourceGroupName
$subnetConfig = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnetConfig -Name $subnetName
$appGWpublicIP = New-AzPublicIpAddress -ResourceGroupName $appGWresourceGroupName -Location $location -Name $appGWpublicIPname -AllocationMethod Static -Sku Standard -Zone ([string]::Empty)
#endregion Network

Get-AzPublicIpAddress -Name Foo01 -ResourceGroupName $appGWresourceGroupName

$resourceGroup = Get-AzResourceGroup -Name 'AppGWTest01'




$appGW = Get-AzApplicationGateway -Name 'Spoke-NonProd-EastUS2-01-AppGW-01' -ResourceGroupName $resourceGroup.ResourceGroupName

# Create the app gateway
$sku = New-AzApplicationGatewaySku -Name Standard_v2 -Tier Standard_v2

$appGW = New-AzApplicationGateway -Name 