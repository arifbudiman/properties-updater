# Setup
$originalFileName = "example.properties"

$keyValuePairs = @{
    "db.host" = "pegasus.fantasy.io"
    "db.user" = "janedoe"
    "db.port" = "8888"
    "person.name.first" = "John"
    "person.name.last" = "Doe"
    "person.company" = "Cyberdyne Systems"
    "person.address" = "400 S Flower St"
    "person.city" = "Los Angeles"
    "person.state" = "California"
    "person.postalCode" = "90071"
}

# Create a backup file with filename format "backup.yyyy-MM-dd-HH-mm.originalFileName"
$dateTimeStamp = $([datetime]::now.ToString('yyyy-MM-dd-HHmm'))
$backupFileName = "backup.$dateTimeStamp.$originalFileName"
Copy-Item $originalFileName $backupFileName

# Get the content of the backup file.
$fileContent = Get-Content $backupFileName

# Find and replace the relevant key/value pairs in the file content
foreach ($keyValue in $keyValuePairs.GetEnumerator()) {
    # Write-Host "$($keyValue.Name): $($keyValue.Value)"
    $regex = "^" + $($keyValue.Name) + "\s*=\s*[^\n\r]+"
    $fileContent = $fileContent -replace $regex, "$($keyValue.Name) = $($keyValue.Value)"
}

# Create a stage file with filename format "staged.yyyy-MM-dd-HH-mm.originalFileName"
$stageFileName = "staged.$dateTimeStamp.$originalFileName"
Set-Content -Path $stageFileName -Value $fileContent
# Write-Host $fileContent
