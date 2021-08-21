param($pFolder, $pa2)
write-host 
write-host "There are a total of $($args.count) arguments"
for ( $i = 0; $i -lt $args.count; $i++ ) {
    
    write-host "$args[$i] = $($args[$i]) "
}
write-host 

Try{Remove-Item -path $pFolder -force -ErrorAction Stop}
Catch{ Write-Warning -Message "Couldn't delete.. "}




write-host got $pFolder

return $data = "10","11","12","13"

