# Creat Data Folder if Not Exist, Set Datafile Variable
if (!(Test-Path .\Data -PathType Container)){New-Item  -Path .\Data -itemType Directory}
$dataFile = ".\Data\settings.txt"

# Deal with Local Notepad Location\
if (!(Test-Path -Path $dataFile -PathType Leaf)){
Write-Host Setting File Not exist -ForegroundColor Red
$null = Read-Host -Prompt "Please Hit Enter To choose your Portable Notepad++ Location"

Add-Type -AssemblyName System.Windows.Forms
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('MyComputer') }
$null = $FileBrowser.ShowDialog()

$aApp = $FileBrowser.FileName
Write-Host you choose the File: $aApp
Set-Content -Path $dataFile -Value $aApp -Force

} else {
$aApp = Get-Content -Path .\Data\settings.txt
## TODO check if content is valid
if($aApp -like "*notepad++.exe"){Write-Host "$aApp contaiiiin"}else{Write-Host " $aApp NOT contaiiiin"}
Write-Host 
Write-Host "Your Portable Notepad++ Location is Set to:"
Write-Host "    " $aApp -ForegroundColor Green
Write-Host
$ChangeDir = Read-Host "Do you Want To Change it ? (y/n)[Enter for No]"
	if ($ChangeDir -eq "y" ){
	Add-Type -AssemblyName System.Windows.Forms
	$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
	InitialDirectory = [Environment]::GetFolderPath('MyComputer') 
	Filter = 'notepad++.exe (*.exe)|notepad++.exe'
	}
		if($FileBrowser.ShowDialog() -eq "ok"){
		Write-Host hhehehe
		$aApp = $FileBrowser.FileName
		Write-Host you Change the File to: $aApp -ForegroundColor Green
		}else{
		Write-Host You Cancel Operation
		Write-Host "your Current npp Location is:" $aApp -ForegroundColor Green
		}
	}

}

# Notepadd++ Latest Version
$repo = "https://api.github.com/repos/notepad-plus-plus/notepad-plus-plus/releases/latest"
$latestRelease = Invoke-WebRequest $repo -Headers @{"Accept"="application/json"}
$json = $latestRelease.Content | ConvertFrom-Json
$latestVersion = $json.tag_name
$npp = $latestVersion.Trim("v"," ")


$VersionInfo = (Get-Item $aApp).VersionInfo
$bb = ("{0}.{1}.{2}" -f $VersionInfo.FileMajorPart,$VersionInfo.FileMinorPart, $VersionInfo.FileBuildPart)

Write-Host
Write-Host "Github Notepadd++ Version is: " $npp
Write-Host "  Your Notepadd++ Version is: " $bb
Write-Host

if ([System.Version]$npp -gt [System.Version]$bb) {
	Write-Host "Remote Version" $npp "> Local" $bb -ForegroundColor Red} 
if ([System.Version]$npp -lt [System.Version]$bb) {
	Write-Host "Remote Version" $npp "< Local" $bb} 
if ([System.Version]$npp -eq [System.Version]$bb) {
	Write-Host "Remote Version" $npp "= Local" $bb -ForegroundColor Green} 


Write-Host
$Agree = Read-Host -Prompt "Do you Want to download and Install a Fresh Copy of Notepad ? [y/n]" 
if (($Agree -eq "y") -or ($Agree -eq "ye")) {
    Write-Host "you type [$Agree] we continue Download and install" -ForegroundColor Green
} elseif ($Agree -eq "n"){
    Write-Warning -Message "you type n"
} else {
    Write-Warning -Message "No Good Answer Provide [$Agree]. we Continue"
}

# Add-Type -AssemblyName System.Windows.Forms
# $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('MyComputer') }
# $null = $FileBrowser.ShowDialog()
# Write-Host
# Write-Host you choose the File: $FileBrowser.FileName
