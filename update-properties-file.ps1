$originalFileName = "example.properties"
$dateTimeStamp = $([datetime]::now.ToString('yyyy-MM-dd-HHmm'))
$backupFileName = "example.properties.backup.$dateTimeStamp"
$stageFileName = "staged-$originalFileName-$dateTimeStamp"

# Make a backup
Copy-Item $originalFileName $backupFileName

# Now operate on the backup file.
$fileContent = Get-Content $backupFileName
$fileContent = $fileContent -replace '^db\.port\s*=\s*[^\n\r]+', 'db.port = 9696'
$fileContent = $fileContent -replace '^person\.name\.first\s*=\s*[^\n\r]+', 'person.name.first = John'
$fileContent = $fileContent -replace '^person\.name\.last\s*=\s*[^\n\r]+', 'person.name.last = Doe'
$fileContent = $fileContent -replace '^person\.company\s*=\s*[^\n\r]+', 'person.company = Cyberdyne Systems'
$fileContent = $fileContent -replace '^person\.address\s*=\s*[^\n\r]+', 'person.address = 400 S Flower St'
$fileContent = $fileContent -replace '^person\.city\s*=\s*[^\n\r]+', 'person.city = Los Angeles'
$fileContent = $fileContent -replace '^person\.state\s*=\s*[^\n\r]+', 'person.state = California'
$fileContent = $fileContent -replace '^person\.postalCode\s*=\s*[^\n\r]+', 'person.postalCode = 00000'

# Create a stage file for deployment
Set-Content -Path $stageFileName -Value $fileContent
