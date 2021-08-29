
$condition = $true # it is a bool type
write-host "condition type:" $condition.GetType().Name

if ( $condition -is [string] )
{
    # do something
}

# Calling .\args2.ps1 with Params
$data =. .\args2.ps1 -aa "aa55" $true -ca "ca22"


# Returning data from .\args2.ps1 in the form of $data[2]
write-host "i am .\args1.ps1 and got data[2] from .\args2.ps1 =" $data[2]
