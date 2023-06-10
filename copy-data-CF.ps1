Clear-Host
write-host "Starting script at $(Get-Date)"

Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name Az.Synapse -Force

# Handle cases where the user has multiple subscriptions
$subs = Get-AzSubscription | Select-Object
if($subs.GetType().IsArray -and $subs.length -gt 1){
    Write-Host "You have multiple Azure subscriptions - please select the one you want to use:"
    for($i = 0; $i -lt $subs.length; $i++)
    {
            Write-Host "[$($i)]: $($subs[$i].Name) (ID = $($subs[$i].Id))"
    }
    $selectedIndex = -1
    $selectedValidIndex = 0
    while ($selectedValidIndex -ne 1)
    {
            $enteredValue = Read-Host("Enter 0 to $($subs.Length - 1)")
            if (-not ([string]::IsNullOrEmpty($enteredValue)))
            {
                if ([int]$enteredValue -in (0..$($subs.Length - 1)))
                {
                    $selectedIndex = [int]$enteredValue
                    $selectedValidIndex = 1
                }
                else
                {
                    Write-Output "Please enter a valid subscription number."
                }
            }
            else
            {
                Write-Output "Please enter a valid subscription number."
            }
    }
    $selectedSub = $subs[$selectedIndex].Id
    Select-AzSubscription -SubscriptionId $selectedSub
    az account set --subscription $selectedSub
}

# Prompt user for a password for the SQL Database
$sqlUser = "SQLUser"
write-host ""
$sqlPassword = ""
$sqlDatabaseName = "sqldwfc"
$complexPassword = 0

# Register resource providers
Write-Host "Registering resource providers...";
$provider_list = "Microsoft.Synapse", "Microsoft.Sql", "Microsoft.Storage", "Microsoft.Compute"
foreach ($provider in $provider_list){
    $result = Register-AzResourceProvider -ProviderNamespace $provider
    $status = $result.RegistrationState
    Write-Host "$provider : $status"
}

$suffix = "ofnbgea"

$resourceGroupName = "dp500-$suffix"


# Create Synapse workspace
$synapseWorkspace = "synapse$suffix"
$dataLakeAccountName = "datalake$suffix"



# Set variables
$destinationFileSystemName = "files"
$destinationDirectoryName = "data"
#$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $dataLakeAccountName

write-host $dataLakeAccountName

write-host $destinationFileSystemName

write-host $destinationDirectoryName

# Copy the files
#azcopy copy "https://couponfollowdehiring.blob.core.windows.net/hiring/Data.zip?sv=2021-10-04&st=2023-05-26T16%3A27%3A33Z&se=2024-05-27T16%3A27%3A00Z&sr=b&sp=r&sig=0rPNqOglARvrvLEr6CmY3V6LcYGi9yxSmoW73UloYis%3D" "https://$dataLakeAccountName.dfs.core.windows.net/$destinationFileSystemName/$destinationDirectoryName" --recursive=true
#azcopy copy "https://couponfollowdehiring.blob.core.windows.net/hiring/Data.zip?sv=2021-10-04&st=2023-05-26T16%3A27%3A33Z&se=2024-05-27T16%3A27%3A00Z&sr=b&sp=r&sig=0rPNqOglARvrvLEr6CmY3V6LcYGi9yxSmoW73UloYis%3D" "https://datalakeofnbgea.blob.core.windows.net/files/data?sp=r&st=2023-06-05T15:24:10Z&se=2023-06-05T23:24:10Z&spr=https&sv=2022-11-02&sr=d&sig=jSB76iwBNFIdGDLg4pGGC521MgQ%2Fp10xJaIirXAmfOw%3D&sdd=1" --recursive=true


azcopy copy "https://couponfollowdehiring.blob.core.windows.net/hiring/Data.zip?sv=2021-10-04&st=2023-05-26T16%3A27%3A33Z&se=2024-05-27T16%3A27%3A00Z&sr=b&sp=r&sig=0rPNqOglARvrvLEr6CmY3V6LcYGi9yxSmoW73UloYis%3D" 
"https://datalakeofnbgea.blob.core.windows.net/files/data?sp=racw&st=2023-06-05T15:37:31Z&se=2023-06-29T23:37:31Z&spr=https&sv=2022-11-02&sr=d&sig=XlrBMISn6k2JSj5SKtAvqbYZ7Ex%2FsBKvN6bTWvas7Y4%3D&sdd=1" --recursive=true

azcopy copy "https://shellstorageor.blob.core.windows.net/cfsource/Data.zip?sv=2021-10-04&spr=https%2Chttp&st=2023-06-05T15%3A19%3A10Z&se=2023-06-30T15%3A19%3A00Z&sr=b&sp=r&sig=%2FFNxsYynHYzFJXigticCnfnOOyPwzekbcQKEyAi9d1I%3D" 
"https://datalakeofnbgea.blob.core.windows.net/files/data?sp=racw&st=2023-06-05T15:37:31Z&se=2023-06-29T23:37:31Z&spr=https&sv=2022-11-02&sr=d&sig=XlrBMISn6k2JSj5SKtAvqbYZ7Ex%2FsBKvN6bTWvas7Y4%3D&sdd=1" --recursive=true

azcopy copy "C:\test" "https://datalakeofnbgea.blob.core.windows.net/files/data?sp=racw&st=2023-06-05T15:37:31Z&se=2023-06-29T23:37:31Z&spr=https&sv=2022-11-02&sr=d&sig=XlrBMISn6k2JSj5SKtAvqbYZ7Ex%2FsBKvN6bTWvas7Y4%3D&sdd=1" --recursive=true



#azcopy copy "C:\local\path" "https://account.blob.core.windows.net/mycontainer1/?sv=2018-03-28&ss=bjqt&srt=sco&sp=rwddgcup&se=2019-05-01T05:01:17Z&st=2019-04-30T21:01:17Z&spr=https&sig=MGCXiyEzbtttkr3ewJIh2AR8KrghSy1DGM9ovN734bQF4%3D" --recursive=true

azcopy copy "https://couponfollowdehiring.blob.core.windows.net/hiring/Data.zip?sv=2021-10-04&st=2023-05-26T16%3A27%3A33Z&se=2024-05-27T16%3A27%3A00Z&sr=b&sp=r&sig=0rPNqOglARvrvLEr6CmY3V6LcYGi9yxSmoW73UloYis%3D" "https://datalakeofnbgea.blob.core.windows.net/files/data/Data.zip?sp=racw&st=2023-06-05T15:37:31Z&se=2023-06-29T23:37:31Z&spr=https&sv=2022-11-02&sr=d&sig=XlrBMISn6k2JSj5SKtAvqbYZ7Ex%2FsBKvN6bTWvas7Y4%3D&sdd=1" --recursive=true


azcopy copy "https://couponfollowdehiring.blob.core.windows.net/hiring/Data.zip?sv=2021-10-04&st=2023-05-26T16%3A27%3A33Z&se=2024-05-27T16%3A27%3A00Z&sr=b&sp=r&sig=0rPNqOglARvrvLEr6CmY3V6LcYGi9yxSmoW73UloYis%3D" "https://datalakeofnbgea.blob.core.windows.net/files/data/Data.zip?sp=racw&st=2023-06-05T15:37:31Z&se=2023-06-29T23:37:31Z&spr=https&sv=2022-11-02&sr=d&sig=XlrBMISn6k2JSj5SKtAvqbYZ7Ex%2FsBKvN6bTWvas7Y4%3D&sdd=1" --recursive=true --decompress

azcopy copy "https://couponfollowdehiring.blob.core.windows.net/hiring/Data.zip?sv=2021-10-04&st=2023-05-26T16%3A27%3A33Z&se=2024-05-27T16%3A27%3A00Z&sr=b&sp=r&sig=0rPNqOglARvrvLEr6CmY3V6LcYGi9yxSmoW73UloYis%3D" "https://shellstorageor.blob.core.windows.net/cfsource/Data.zip?sv=2021-10-04&st=2023-06-05T16%3A03%3A39Z&se=2023-06-30T16%3A03%3A00Z&sr=c&sp=racwl&sig=GWXg2%2B78PA0%2BEM67Gg%2FTa%2BxOJZWs0epipVM%2FUWp1N%2BM%3D" --recursive=true

write-host "Script completed at $(Get-Date)"



azcopy copy "https://datalakeofnbgea.blob.core.windows.net/files/data/Data.zip?sp=r&st=2023-06-05T16:49:12Z&se=2023-06-09T00:49:12Z&spr=https&sv=2022-11-02&sr=b&sig=Y3wYKuwIIqY52ZTXCryrnz%2BJ0P2knhcNA9WfJwHJVQg%3D" "https://datalakeofnbgea.blob.core.windows.net/files/data/Data.zip?sp=r&st=2023-06-05T16:49:12Z&se=2023-06-09T00:49:12Z&spr=https&sv=2022-11-02&sr=b&sig=Y3wYKuwIIqY52ZTXCryrnz%2BJ0P2knhcNA9WfJwHJVQg%3D" --decompress