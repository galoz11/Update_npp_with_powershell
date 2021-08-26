
param($aa, $ba='Odyessy', $ca,[Parameter(Mandatory)]$servername) #should be the first line of a script


write-host aa = $aa
write-host ca = $ca
write-host ba = $ba
write-host servername = $servername
Write-host "servername type:" $servername.GetType().Name
write-host "ba type:" $ba.GetType().Name

write-host "There are a total of $($param.count) arguments"

write-host

$data = 'Zer_gi453','OneBBBB345','Two354','Three35434' 
return $data