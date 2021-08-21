
param($aa, $ba='Odyessy', $ca,[Parameter(Mandatory)]$servername) #should be the first line of a script


write-host
write-host aa = $aa
write-host
write-host ca = $ca
write-host
write-host ba = $ba
write-host
write-host servername = $servername
write-host
Write-host "servername type:" $servername.GetType().Name
write-host "ba type:" $ba.GetType().Name


write-host "There are a total of $($param.count) arguments"

write-host

$data = 'Zero3453453','One354345','Two354','Three35434' 
return $data