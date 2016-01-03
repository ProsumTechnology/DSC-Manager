# These variables are specfic settings for each target node that get applied to the DSC configiguration template
$LabHosts = @{ 
    AllNodes = @( 
        @{ 
            NodeName = "dc-01"
            Service = 'DC'
            Role = 'PDC'
            DNSServerAddresses = "192.168.1.102","127.0.0.1"
            Location = 'Private'
        },

        @{ 
            NodeName = "dc-02"
            Service = 'DC'
            DNSServerAddresses = "192.168.1.100","127.0.0.1"
            Location = 'Private'
        },

         @{ 
            NodeName = "runbook-01"
            Service = 'DSC'
            Location = 'Private'
        }
    ); 
}
