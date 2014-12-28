param(
    [string]$DNSHostname, 
    [string]$PrimaryDNSServer, 
    [string]$SecondaryDNSServer
)

$DNSArray = @($PrimaryDNSServer,$SecondaryDNSServer)
$DNSHashedValues = @{DNSServer = ''; ResolvedIPAddress = ''}

function resolveDNS {
		$DNSHashedValues.DNSServer = $element
		$FormattedIPAddress = Resolve-DnsName -name $DNSHostname -Server $element -Type A | Select -Property IPAddress
		$DNSHashedValues.ResolvedIPAddress = $FormattedIPAddress.IPAddress
		$DNSHashedValues
		Write-Host '----------'
}

Write-Host "Usage: dns-queryd.ps1 -target [hostname] -primaryDNS [IP address] -secondaryDNS [IP Address]"
Write-Host "Domain name:" $DNSHostname

foreach ($element in $DNSArray) {
	if ($element -eq $DNSArray[0]) {
		Write-Host "Resolving host name using primary DNS server" $PrimaryDNSServer
		resolveDNS
	} elseif ($element -eq $DNSArray[1]) {
		Write-Host "Resolving host name using secondary DNS server" $PrimaryDNSServer
		resolveDNS
	} else {	
		Write-Host "Error: use only primary or secondary DNS servers."
		break
	}
}