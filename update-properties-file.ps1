# Setup
$originalFileName = "example.properties"

$keyAndTargetValuePairs = @{
  "db.host"           = "pegasus.fantasy.io"
  "db.user"           = "John.Doe"
  "db.port"           = "8888"
  "person.name.first" = "John"
  "person.name.last"  = "Doe"
  "person.company"    = "Cyberdyne Systems"
  "person.address"    = "400 S. Flower St"
  "person.city"       = "Los Angeles"
  "person.state"      = "California"
  "person.postalCode" = "90071"
  "pass.complexity"   = "^(?:(?=.*[a-z])(?:(?=.*[A-Z])(?=.*[\d\W])|(?=.*\W)(?=.*\d))|(?=.*\W)(?=.*[A-Z])(?=.*\d)).{8,}$"
  "non.existent.key"  = "Non Existent Value"
}

# Create a backup file with filename format "backup.yyyy-MM-dd_HHmmss.originalFileName"
$dateTimeStamp = $([datetime]::now.ToString('yyyy-MM-dd_HHmmss'))
$backupFileName = "backup.$dateTimeStamp.$originalFileName"
Write-Host "Creating a backup of ${originalFileName} file..."
Copy-Item $originalFileName $backupFileName
Write-Host "The file ${originalFileName} has been backed up to ${backupFileName}"

# Get the content of the backup file.
Write-Host "`r`nReading the content of ${backupFileName} into memory..."
$fileContent = Get-Content $backupFileName

# Find and replace the relevant key/value pairs in the file content
Write-Host "Performing find and replace to the content in memory..."
foreach ($keyAndTargetValue in $keyAndTargetValuePairs.GetEnumerator()) {
  $regex = "^" + $keyAndTargetValue.Key + "\s*=\s*[^\n\r]+"
  $found = $fileContent | Select-String -Pattern $regex
  if ($found.Matches.Length -gt 0) {
    Write-Host "`r`nThe following configuration key-value pair is found:"
    Write-Host $found
    $replacementValue = $keyAndTargetValue.Key + " = " + $keyAndTargetValue.Value
    $fileContent = $fileContent -replace $regex, $replacementValue
    Write-Host "and is replaced with:"
    Write-Host $replacementValue
  }
  else {
    Write-Host "`r`nThe following configuration key can't be found:"
    Write-Host $keyAndTargetValue.Key
  }
}

# Create a stage file with filename format "staged.yyyy-MM-dd-HH-mm.originalFileName"
$stageFileName = "staged.$dateTimeStamp.$originalFileName"
Write-Host "`r`nSaving the updated content in memory to ${stageFileName} file..."
Set-Content -Path $stageFileName -Value $fileContent
Write-Host "Updated content has been saved to ${stageFileName} file."
