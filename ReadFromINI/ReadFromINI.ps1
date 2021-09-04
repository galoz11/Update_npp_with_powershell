
function Get-IniFile {  
    [CmdletBinding()]
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
            write-debug $matches[1]  
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

# Crear an hash Object and call its members
$testIni  = Get-IniFile 'g.ini'
$server = $testIni.database.server
$organization = $testIni.NoSection.guy
Write-Host "database server is =" $server
Write-Host "NoSection guy is  =" $organization
Write-Host "testIni['NoSection'] =" $testIni['NoSection']
$testIni['NoSection']


function Set-OrAddIniValue
{
    Param(
        [string]$FilePath,
        [hashtable]$keyValueList
    )
    $content = Get-Content $FilePath
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

    $content | Set-Content $FilePath
}

Set-OrAddIniValue -FilePath 'g.ini'  -keyValueList @{
    UserName = "myName"
    UserEmail = "myEmail"
    UserNewField = "SeemsToWork"
}