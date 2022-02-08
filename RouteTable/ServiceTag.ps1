#region parameters
$resourceGroupName = 'HubSpokeTest01'
$routeTableName    = 'FooTable'
#endregion paramters

$routeTable = Get-AzRouteTable -ResourceGroupName $resourceGroupName -Name $routeTableName
Add-AzRouteConfig -Name 'AzureCloud' -AddressPrefix 'AzureCloud' -NextHopType Internet -RouteTable $routeTable
Set-AzRouteTable -RouteTable $routeTable