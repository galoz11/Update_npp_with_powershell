
function Get-IniFile 
{  
    param(  
        [parameter(Mandatory = $true)] [string] $filePath  
    )  
    
    $anonymous = "NoSection"
  
    $ini = @{}  
    switch -regex -file $filePath  
    {  
        "^\[(.+)\]$" # Section  
        {  
            $section = $matches[1]  
            $ini[$section] = @{}  
            $CommentCount = 0  
        }  

        "^(;.*)$" # Comment  
        {  
            if (!($section))  
            {  
                $section = $anonymous  
                $ini[$section] = @{}  
            }  
            $value = $matches[1]  
            $CommentCount = $CommentCount + 1  
            $name = "Comment" + $CommentCount  
            $ini[$section][$name] = $value  
        }   

        "(.+?)\s*=\s*(.*)" # Key  
        {  
            if (!($section))  
            {  
                $section = $anonymous  
                $ini[$section] = @{}  
            }  
            $name,$value = $matches[1..2]  
            $ini[$section][$name] = $value  
        }  
    }  

    return $ini  
}  

$testIni  = Get-IniFile 'g.ini'
$server = $testIni.database.server
$organization = $testIni.owner.organization
$server
$organization


function Set-OrAddIniValue
{
    Param(
        [string]$FilePath,
        [hashtable]$keyValueList
    )

    $content = Get-Content 'G:\PowerShell\g.ini'

    $keyValueList.GetEnumerator() | ForEach-Object {
        if ($content -match "^$($_.Key)=")
        {
            $content= $content -replace "^$($_.Key)=(.*)", "$($_.Key)=$($_.Value)"
        }
        else
        {
            $content += "$($_.Key)=$($_.Value)"
        }
    }

    $content | Set-Content 'G:\PowerShell\g.ini'
}

Set-OrAddIniValue -FilePath ‪'G:\PowerShell\g.ini'  -keyValueList @{
    UserName = "myName"
    UserEmail = "myEmail"
    UserNewField = "SeemsToWork"
}