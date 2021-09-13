param([Parameter(Mandatory)]$pathFolder, $extract=$false) 
 # "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.1.3/npp.8.1.3.portable.x64.7z"

# Get the Latest Notepad++ Version
$repo = "https://api.github.com/repos/notepad-plus-plus/notepad-plus-plus/releases/latest"
$latestRelease = Invoke-WebRequest $repo -Headers @{"Accept"="application/json"}
$json = $latestRelease.Content | ConvertFrom-Json
$latestVersion = $json.tag_name
$versionTrim = $latestVersion.Trim("v"," ")
$fileName = "npp.$versionTrim.portable.x64.zip"

Write-Host Dowloading latest release
$download = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/$latestVersion/$fileName"
Write-Host $download
Write-Host $fileName
Write-Host $ENV:UserProfile\Desktop\$fileName
Write-Host $pathFolder 
# this is how to refer to user descktop..
# $pathFile = "$ENV:UserProfile\Desktop\$fileName"
$pathFile = "$pathFolder$fileName"

Invoke-WebRequest $download -OutFile $pathFile # simple download (web location to file name)

#$extrac is default to false unless calling param say it true, and the extract will happend
if($extract){Expand-Archive -Path $pathFile -DestinationPath $pathFolder -Force}