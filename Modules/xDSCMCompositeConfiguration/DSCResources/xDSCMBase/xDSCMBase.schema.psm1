Configuration xDSCMBase
{
    param (
        [Parameter(Mandatory=$false)][ValidateNotNullorEmpty()][array]$DNSServerAddresses,
        [Parameter(Mandatory=$true)][ValidateNotNullorEmpty()][string]$Location
        )
    
    Import-DSCResource -ModuleName xNetworking

    If ($DNSServerAddresses) {
        xDNSServerAddress  DNSCustom {
            Address = $DNSServerAddresses
            InterfaceAlias = "Ethernet"
            AddressFamily = "IPV4"
            }
        }

    If (($Location -eq "Private") -and !($DNSServerAddresses)) {
        xDNSServerAddress  DNSPrivate {
            Address = "192.168.1.100","192.168.1.102"
            InterfaceAlias = "Ethernet"
            AddressFamily = "IPV4"
            }
        }
}
