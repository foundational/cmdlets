param(
    [string]$DNSHostname, 
    [string]$PrimaryDNSServer, 
    [string]$SecondaryDNSServer
)

$DNSArray = @($PrimaryDNSServer,$SecondaryDNSServer)
$DNSHashedValues = @{DNSServer = ''; ResolvedIPAddress = ''}

Write-Host "Usage: dns.ps1 -target [hostname] -primaryDNS [IP address] -secondaryDNS [IP Address]"
Write-Host "Domain name:" $DNSHostname
foreach ($element in $DNSArray) {
	$DNSHashedValues.DNSServer = $element
	$FormattedIPAddress = Resolve-DnsName -name $DNSHostname -Server $element -Type A | Select -Property IPAddress
	$DNSHashedValues.ResolvedIPAddress = $FormattedIPAddress.IPAddress
    $DNSHashedValues
    Write-Host '----------'
}