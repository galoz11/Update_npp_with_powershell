
$condition = $true # it is a bool type

write-host "condition type:" $condition.GetType().Name

if ( $condition -is [string] )
{
    # do something
}
$data =. .\args2.ps1 -aa "aa55" $true -ca "ca22"

write-host "i am .\args1.ps1 and got data[2] from .\args2.ps1 =" $data[2]
