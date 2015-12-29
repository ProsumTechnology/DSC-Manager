Configuration MasterConfig
{
    Import-DscResource -Name DC
    
    Node $AllNodes.Where{$_.Service -eq "DC"}.NodeName {
        DC BaseConfig
        {
            Role = $Node.Role
        }
    }
}