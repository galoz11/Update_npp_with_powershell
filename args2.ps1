
param($aa, $ba, $ca)


write-host 
write-host  $args[0]
write-host 
write-host $args[1]
write-host 
write-host $args[2]

write-host "There are a total of $($args.count) arguments"
for ( $i = 0; $i -lt $args.count; $i++ ) {
    
    write-host "$args[$i] = $($args[$i]) "
}
write-host 