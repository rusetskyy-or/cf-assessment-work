az role assignment create \
    --role "Storage Blob Data Contributor" \
    --assignee <email> \
    --scope "/subscriptions/<subscription>/resourceGroups/<resource-group>/providers/Microsoft.Storage/storageAccounts/<storage-account>"


    az storage container generate-sas \
    --account-name <storage-account> \
    --name <container> \
    --permissions acdlrw \
    --expiry <date-time> \
    --auth-mode login \
    --as-user

    az storage container generate-sas \
    --account-name shellstorageor \
    --name cfsource \
    --permissions acdlrw \
    --expiry '2023-06-30' \
    --auth-mode login \
    --as-user
az storage container generate-sas --account-name shellstorageor --name cfsource --permissions acdlrw --expiry '2023-06-30' --auth-mode login --as-user

$CurrentDate = Get-Date
$ExpiryDate = $CurrentDate.AddDays(7).ToString("yyyy-MM-dd")
$SasToken = az storage container generate-sas --account-name shellstorageor --name cfsource --permissions acdlrw --expiry $ExpiryDate --auth-mode login --as-user
