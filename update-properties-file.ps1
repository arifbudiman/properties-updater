# Setup
$originalFileName = "example.properties"

$keyAndTargetValuePairs = @{
  "db.host"           = "pegasus.fantasy.io"
  "db.user"           = "John.Doe"
  "db.port"           = "8888"
  "person.name.first" = "John"
  "person.name.last"  = "Doe"
  "person.company"    = "Cyberdyne Systems"
  "person.address"    = "400 S Flower St"
  "person.city"       = "Los Angeles"
  "person.state"      = "California"
  "person.postalCode" = "90071"
}

# Create a backup file with filename format "backup.yyyy-MM-dd_HHmmss.originalFileName"
$dateTimeStamp = $([datetime]::now.ToString('yyyy-MM-dd_HHmmss'))
$backupFileName = "backup.$dateTimeStamp.$originalFileName"
Copy-Item $originalFileName $backupFileName

# Get the content of the backup file.
$fileContent = Get-Content $backupFileName

# Find and replace the relevant key/value pairs in the file content
foreach ($keyAndTargetValue in $keyAndTargetValuePairs.GetEnumerator()) {
  # Write-Host "$($keyValue.Name): $($keyValue.Value)"
  $regex = "^" + $($keyAndTargetValue.Name) + "\s*=\s*[^\n\r]+"
  $fileContent = $fileContent -replace $regex, "$($keyAndTargetValue.Name) = $($keyAndTargetValue.Value)"
}

# Create a stage file with filename format "staged.yyyy-MM-dd-HH-mm.originalFileName"
$stageFileName = "staged.$dateTimeStamp.$originalFileName"
Set-Content -Path $stageFileName -Value $fileContent
# Write-Host $fileContent
