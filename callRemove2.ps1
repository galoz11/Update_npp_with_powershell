write-host
write-host i am call2.ps1 and calling to callRemove3.ps1
write-host

# . .\RemoveAndExlude1.ps1 -pa2 "wordPa1" -pa1 "wordPa2"
# ; is use to write command in the same line
$pFolder = "D:\myScripts\Powershell\ttt"

Try{. .\callRemove3.ps1 -pFolder D:\myScripts\Powershell\ttt -pa1 "wordPa2" -ErrorAction Stop}
Catch{Write-Warning "The File: callRemove3.ps1 couldn't be found.."; exit 71}


write-host mmm $data[2]