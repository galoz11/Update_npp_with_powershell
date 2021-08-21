

Write-Host i am first power.ps1 $args[0]

# calling other ps1 file
$xxx = . .\power2.ps1 guy




# returning from other file with args
$ccc = $xxx[2]
Write-Host "i am first but: $ccc, come from second"
