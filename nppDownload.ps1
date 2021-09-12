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
# $pathFile = "$ENV:UserProfile\Desktop\$fileName"
# $pathFile = "E:\tmp\nppDownload\$fileName"
$pathFile = "$pathFolder$fileName"

Invoke-WebRequest $download -OutFile $pathFile

#Expand-Archive -LiteralPath $pathFile -DestinationPath "G:\GitTests\ff\nnn"
if($extract){Expand-Archive -Path $pathFile -DestinationPath E:\tmp\nppDownload -Force}