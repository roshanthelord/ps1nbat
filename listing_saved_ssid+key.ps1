set-executionpolicy unrestricted; foreach ($profile in netsh wlan show profiles | Select-String -Pattern "All User Profile" | ForEach-Object {($_ -split ":")[1].Trim()}) {
    $keyInfo = netsh wlan show profile name=$profile key=clear | Select-String -Pattern "Key Content"
    if ($keyInfo) {
        $key = ($keyInfo -split ":")[1].Trim()
        Write-Host "SSID: $profile"
        Write-Host "Key: $key"
        Write-Host "---------------------------------"
    } else {
        Write-Host "SSID: $profile"
        Write-Host "Key: (No key set)"
        Write-Host "---------------------------------"
    }
}; set-executionpolicy restricted;
