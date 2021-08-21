
$condition = $true # it is a bool type

write-host "condition type:" $condition.GetType().Name

if ( $condition -is [string] )
{
    # do something
}


$data =. .\args2.ps1 -aa "aa55" $true -ca "ca22"


write-host hi from $data[2]
