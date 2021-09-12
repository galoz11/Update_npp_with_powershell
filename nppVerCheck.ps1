# Creat Data Folder if Not Exist, Set Datafile Variable
if (!(Test-Path .\Data -PathType Container)){New-Item  -Path .\Data -itemType Directory}
$dataFile = ".\Data\settings.txt"

# Deal with Local Notepad Location\
if (!(Test-Path -Path $dataFile -PathType Leaf)){ # if file not exist, do that:
	Write-Host 'Configurations File Not exist' -ForegroundColor Red
	$null = Read-Host -Prompt "Please Hit Enter To choose your Portable Notepad++ Location"

	Add-Type -AssemblyName System.Windows.Forms
	$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('MyComputer') }
	$null = $FileBrowser.ShowDialog()

	$aApp = $FileBrowser.FileName
	Write-Host 'you choose the File: ' $aApp
	Set-Content -Path $dataFile -Value $aApp -Force #creating Conf file with settings

} else { #if file exist then:
	$aApp = Get-Content -Path $dataFile
	## TODO check if content is valid
	if($aApp -like "*notepad++.exe"){Write-Host "$aApp is Good " -ForegroundColor Green ; $status = $true}else{
		Write-Host " $aApp is Bad" -ForegroundColor Red ; $status = $false}
	Write-Host 
	Write-Host "Your Portable Notepad++ Location is Set to:"
	Write-Host "    " $aApp -ForegroundColor Green
	if(!$status){Write-Host 'But Somthing is wrong!' -ForegroundColor Red}
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
			Set-Content -Path $dataFile -Value $aApp
			$status = $true
			}else{
			Write-Host You Cancel Operation
			Write-Host "your Current npp_remote Location is:" $aApp -ForegroundColor Green
			}
		}else{ if (!$status){Write-Host 'Please Fix you npp++ Location folder!'-ForegroundColor Red} }

}

# Notepadd++ Latest Version
$repo = "https://api.github.com/repos/notepad-plus-plus/notepad-plus-plus/releases/latest"
$latestRelease = Invoke-WebRequest $repo -Headers @{"Accept"="application/json"}
$json = $latestRelease.Content | ConvertFrom-Json
$latestVersion = $json.tag_name
$npp_remote = $latestVersion.Trim("v"," ")


if ($status){ # if status is ok (true)
	$VersionInfo = (Get-Item $aApp).VersionInfo
	$npp_local = ("{0}.{1}.{2}" -f $VersionInfo.FileMajorPart,$VersionInfo.FileMinorPart, $VersionInfo.FileBuildPart)
}else{$npp_local = 'not Found'}
Write-Host
Write-Host "Github Notepadd++ Version is: " $npp_remote
Write-Host "  Your Notepadd++ Version is: " $npp_local
Write-Host

if ($status){
	if ([System.Version]$npp_remote -gt [System.Version]$npp_local) {
		Write-Host "Remote Version" $npp_remote "> Local" $npp_local -ForegroundColor Red} 
	if ([System.Version]$npp_remote -lt [System.Version]$npp_local) {
		Write-Host "Remote Version" $npp_remote "< Local" $npp_local} 
	if ([System.Version]$npp_remote -eq [System.Version]$npp_local) {
		Write-Host "Remote Version" $npp_remote "= Local" $npp_local -ForegroundColor Green} 


	Write-Host
	$Agree = Read-Host -Prompt "Do you Want to download and Install a Fresh Copy of Notepad ? [y/n]" 
	if (($Agree -eq "y") -or ($Agree -eq "ye")) {
		Write-Host "you type [$Agree] we continue Download and install" -ForegroundColor Green
	} elseif ($Agree -eq "n"){
		Write-Warning -Message "you type n"
	} else {
		Write-Warning -Message "No Good Answer Provide [$Agree]. we Continue"
	}
}else{
	Write-Host 'No local Copy of npp++ is found, Please Download a fresh Portable copy.' -ForegroundColor Red
}
# Add-Type -AssemblyName System.Windows.Forms
# $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('MyComputer') }
# $null = $FileBrowser.ShowDialog()
# Write-Host
# Write-Host you choose the File: $FileBrowser.FileName
