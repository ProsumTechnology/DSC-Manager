Configuration MasterConfig
{
    Import-DscResource -Name xDSCMDC xDSCMSCCM
    
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
