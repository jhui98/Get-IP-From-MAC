$macAddress = Read-Host -prompt "Please Enter MAC Address"
$macAddress = $macAddress.replace(":","-").ToLower()

#$networkSegment = Read-Host -prompt "Please Enter Subnet Address: "
#$networkSegment = $networkSegment.replace(":","-").ToLower()
$networkSegment = "255.255.255.0"

function GetIPFromMAC {
  Param (
      [string] $macAddress, 
      [string] $networkSegment
  )
  Write-Host "Searching for $macAddress in network segment $networkSegment... `n"
  $ip = arp -a | Select-String $macAddress |% { $_.ToString().Trim().Split(" ")[0] }
  if ($ip -eq $null) {
	Write-Host "$macAddress not found `n"
          }
  return $ip
}

Write-Host "Getting Ip-Address from MAC Address... `n" 
$ipAddress = GetIPFromMac -macAddress $macAddress -networkSegment $networkSegment

if ($ipAddress -ne $null) {
    Set-Clipboard -Value $ipAddress
    Write-Host "----- Found IP Address: $ipAddress -----`n"

    Write-Host "IP Address copied to clipboard `n" 
}

echo "All Operations Complete. Exiting in 10 seconds..."
sleep 10