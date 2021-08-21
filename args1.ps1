
$condition = $true
write-host "condition type:" $condition.GetType().Name


if ( $condition -is [string] )
{
    # do something
}

powershell .\args2.ps1 -aa "aa55" $true -ca "ca22"