Clear-Host
write-host "Starting script at $(Get-Date)"

Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name Az.Synapse -Force



# Register resource providers
Write-Host "Registering resource providers...";
$provider_list = "Microsoft.Synapse", "Microsoft.Sql", "Microsoft.Storage", "Microsoft.Compute"
foreach ($provider in $provider_list){
    $result = Register-AzResourceProvider -ProviderNamespace $provider
    $status = $result.RegistrationState
    Write-Host "$provider : $status"
}

$suffix = "y4ev06c"

$resourceGroupName = "cf-assessment-$suffix"


# Create Synapse workspace
$synapseWorkspace = "synapse$suffix"
$dataLakeAccountName = "datalake$suffix"
$KeyVaultName ="kvdwfc$suffix"
$sourceSasTokenName = "sourceSasToken"
$sourceSasToken = az KeyVault secret show --vault-name $KeyVaultName --name $sourceSasTokenName --query value -o tsv
write-host $sourceSasToken
$sourceFileName = "Data.zip"
$SasTokenName = "stoken"
$SasToken = az KeyVault secret show --vault-name $KeyVaultName --name $SasTokenName --query value -o tsv
write-host $SasToken

# Set variables
$destinationFileSystemName = "files"
$destinationDirectoryName = "data"

write-host $dataLakeAccountName

write-host $destinationFileSystemName

write-host $destinationDirectoryName


# Copy the files
azcopy copy $sourceSasToken "https://$dataLakeAccountName.blob.core.windows.net/files/data/$sourceFileName?$SasToken"

write-host "Script completed at $(Get-Date)"
