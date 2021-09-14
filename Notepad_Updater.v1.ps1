# Guy Boazy Script for Upgrade Notepadd++ Portable version with powershell
# this script will compare your local ver to latest ver on github
# and if neccery will upgrade your ver with backup and restore config files

# SCRIPT START HERE
# Creat Data Folder (if Not Exist), Set Datafile path Variable
$config_folder = '.\Data'
$dataFile = "$config_folder\settings.txt"
$null = if (!(Test-Path $config_folder -PathType Container)){New-Item  -Path $config_folder -itemType Directory}

# Deal with Local Notepad Location\
if (!(Test-Path -Path $dataFile -PathType Leaf)){ # if file not exist, do that:
	Write-Host 'Configurations File Not exist' -ForegroundColor Red
	$null = Read-Host -Prompt "Please Hit Enter To set your Portable Notepad++.exe Location"

	Add-Type -AssemblyName System.Windows.Forms
	$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
		 InitialDirectory = [Environment]::GetFolderPath('MyComputer') 
		 Filter = 'notepad++.exe (*.exe)|notepad++.exe'
		}
	$null = $FileBrowser.ShowDialog()
# this line will work after selecting the file
	$aApp = $FileBrowser.FileName
	Write-Host 'you choose the File: ' $aApp
	Set-Content -Path $dataFile -Value $aApp -Force #creating Conf file with settings
	$status = $true
} else { #if file exist then:
	$aApp = Get-Content -Path $dataFile
	if($aApp -like "*notepad++.exe"){$status = $true}else{$status = $false} ## check if content is valid
	if(Test-Path $aApp){$status = $true}else{$status = $false}
	Write-Host 'Portable Notepad++ Location is Set to:' $aApp -ForegroundColor Green
	if(!$status){Write-Host 'But Somthing is wrong with the path!' -ForegroundColor Red}
	$ChangeDir = Read-Host "`nDo you Want To Change it ? [y/N]"
		if ($ChangeDir -eq "y" ){
		Add-Type -AssemblyName System.Windows.Forms
		$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
		InitialDirectory = [Environment]::GetFolderPath('MyComputer') 
		Filter = 'notepad++.exe (*.exe)|notepad++.exe'
		}
			if($FileBrowser.ShowDialog() -eq "ok"){
			$aApp = $FileBrowser.FileName
			Write-Host you Change the File to: $aApp -ForegroundColor Green
			Set-Content -Path $dataFile -Value $aApp
			$status = $true
			}else{
				Write-Host "`nYou Cancel `"Change Location Setting`" Operation..`n"
			Write-Host "your Current npp_remote Location is:" $aApp -ForegroundColor Green
			}
		}else{ if (!$status){Write-Host 'Please Fix you npp++ Location folder!'-ForegroundColor Red} }
}
$nppFolder = Split-Path -Path $aApp
Write-Host "`nNow Checking Notepadd++ Latest Version form Github.. " -ForegroundColor Green # Notepadd++ Latest Version
$repo = "https://api.github.com/repos/notepad-plus-plus/notepad-plus-plus/releases/latest"
$latestRelease = Invoke-WebRequest $repo -Headers @{"Accept"="application/json"}
$json = $latestRelease.Content | ConvertFrom-Json
$latestVersion = $json.tag_name
$npp_remote = $latestVersion.Trim("v"," ") # this is the latest Ver..

if ($status){ # if status is ok (true), mean that you have a valid local npp
	$VersionInfo = (Get-Item $aApp).VersionInfo
	$npp_local = ("{0}.{1}.{2}" -f $VersionInfo.FileMajorPart,$VersionInfo.FileMinorPart, $VersionInfo.FileBuildPart)
}else{$npp_local = 'not Found'}

Write-Host "`nGithub Notepadd++ Version is: " $npp_remote
Write-Host "  Your Notepadd++ Version is: " $npp_local
Write-Host

if ($status){ # if everything is ok
	if ([System.Version]$npp_remote -gt [System.Version]$npp_local) {
		Write-Host "Remote Version" $npp_remote "> Local" $npp_local -ForegroundColor Red} 
	if ([System.Version]$npp_remote -lt [System.Version]$npp_local) {
		Write-Host "Remote Version" $npp_remote "< Local" $npp_local "..and this is very wierd :/"} 
	if ([System.Version]$npp_remote -eq [System.Version]$npp_local) {
		Write-Host "Remote Version" $npp_remote "= Local" $npp_local -ForegroundColor Green
		$samever = $true} 

	if($samever){write-host 'you version is already up to date'}else{
	Write-Host
	$Agree = Read-Host -Prompt "Do you Want an upgrad to Github Version ? [y/N]" 
	if (($Agree -eq "y") -or ($Agree -eq "ye")) {
		Write-Host "you type [$Agree] we continue Download and install" -ForegroundColor Green
		# . .\nppDownload.ps1 -pathFolder $nppFolder\ -extract $true
		$download = $true 
		}else{Write-Host "`nNo Operation was taking place!`nThank you for using my Script :)`n"}
	}
	}else{Write-Host 'No local Copy of npp++ is found, Please Download a fresh Portable copy.' -ForegroundColor Red	}

# todo check cloud choice ===========================================================================
if ((Test-Path $nppFolder\cloud\choice -PathType Leaf)){
	$cloud = Get-Content -Path $nppFolder\cloud\choice
	Write-host "cloud setting is enable in: $cloud\ "
	}else{Write-Host 'No cloud setting found'}

	
# this is the download part + Back up and restore =======================================
if($download){
	# Backup Configuration files 
	Write-Host "`nBackup Configuration files`n" -ForegroundColor Green
	$bufiles = @('config.xml','contextMenu.xml','langs.xml','nativeLang.xml','shortcuts.xml','stylers.xml')
	$null = if (!(Test-Path $nppFolder\!BackUp -PathType Container)){New-Item  -Path $nppFolder\!BackUp -itemType Directory}
	foreach ($file in $bufiles) {Copy-Item $nppFolder\$file -Destination $nppFolder\!BackUp\ -Force }
		
	$fileName = "npp.$npp_remote.portable.x64.zip"
	Write-Host 'Dowloading latest release..'
	$download = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/$latestVersion/$fileName"
	$pathFile = "$nppFolder\$fileName"
	Invoke-WebRequest $download -OutFile $pathFile # simple download (web location to file name)
	Write-Host 'Unzip the file..'
	Expand-Archive -Path $pathFile -DestinationPath $nppFolder\ -Force  #extract file
	Write-Host "`nRestore Configuration files`n" -ForegroundColor Green
	foreach ($file in $bufiles) {Copy-Item $nppFolder\!BackUp\$file -Destination $nppFolder\ -Force } # Restore Configuration files 
	Remove-Item $pathFile # Delete zip file
	Write-host "`nNotepad++ Was Just upgrade to the latest version!!`nThank you for using this script :)`n" -ForegroundColor Blue 
}