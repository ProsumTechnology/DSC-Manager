Configuration MasterConfig
{
    Import-DscResource -Module xDSCMCompositeConfiguration
    
    Node $AllNodes.where{$_.DNSServerAddresses}.NodeName {    
        xDSCMBase BaseConfig
        {
            DNSServerAddresses = $Node.DNSServerAddresses
            Location =$Node.Location
        }
    }
    
    Node $AllNodes.where{!$_.DNSServerAddresses}.NodeName {    
        xDSCMBase BaseConfig
        {
            Location =$Node.Location
        }
    }

    Node $AllNodes.Where{$_.Service -eq "DC"}.NodeName {
        xDSCMDC DCConfig
        {
            Role = $Node.Role
        }
    }

    Node $AllNodes.Where{$_.Service -eq "SCCM"}.NodeName {
        xDSCMSCCM SCCMConfig
        {
            Role = $Node.Role
            DSLPath = $Node.DSLPath
        }
    }
}
