Clear-Host
write-host "Starting script at $(Get-Date)"

Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name Az.Synapse -Force



# Register resource providers
Write-Host "Registering resource providers...";
#$provider_list = "Microsoft.Synapse", "Microsoft.Sql", "Microsoft.Storage", "Microsoft.Compute"
$provider_list = "Microsoft.Storage"
foreach ($provider in $provider_list){
    $result = Register-AzResourceProvider -ProviderNamespace $provider
    $status = $result.RegistrationState
    Write-Host "$provider : $status"
}

#$suffix = ""

#$resourceGroupName = "CF-assessment-$suffix"
$resourceGroupName = "CF-assessment"
$saName = "shellstorageor"

#Define variables
$containerName = "cfsource"
#$sourceSasToken = "https://couponfollowdehiring.blob.core.windows.net/hiring/Data.zip?sv=2021-10-04&st=2023-05-26T16%3A27%3A33Z&se=2024-05-27T16%3A27%3A00Z&sr=b&sp=r&sig=0rPNqOglARvrvLEr6CmY3V6LcYGi9yxSmoW73UloYis%3D"
$sourceSasToken = "sv=2021-10-04&st=2023-05-26T16%3A27%3A33Z&se=2024-05-27T16%3A27%3A00Z&sr=b&sp=r&sig=0rPNqOglARvrvLEr6CmY3V6LcYGi9yxSmoW73UloYis%3D"


$sourceFileName = "Data.zip"

#Generate SAS token for target container
write-host "Generate SAS token for target container"
$CurrentDate = Get-Date
$ExpiryDate = $CurrentDate.AddDays(7).ToString("yyyy-MM-dd")
$SasToken = az storage container generate-sas --account-name $saName --name $containerName --permissions racw --expiry $ExpiryDate --auth-mode login --as-user
$SasToken = $SasToken.Trim('"')
write-host $SasToken


# Set variables
$destinationDirectoryName = "data"


$targetSasToken = "https://$saName.blob.core.windows.net/$containerName/$DestinationDirectoryName/$sourceFileName"+"?"+$SasToken
write-host $targetSasToken

#download the source file from blob storage using SAS token
az storage blob download --container-name "hiring" --name $sourceFileName --file ./$sourceFileName `
--account-name "couponfollowdehiring" --sas-token $sourceSasToken

#unzip Data.zip files to local folder
unzip Data.zip -d ./data  


# Copy the files
#azcopy copy "$sourceSasToken" "$targetSasToken" --recursive=true
write-host "Script completed at $(Get-Date)"
