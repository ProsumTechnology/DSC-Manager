# These variables are specfic settings for each target node that get applied to the DSC configiguration template
$LabHosts = @{ 
    AllNodes = @( 
        @{ 
            NodeName = "dc-01"
            Service = 'DC'
            Role = 'PDC'
        },

        @{ 
            NodeName = "dc-02"
            Service = 'DC'
        }
    ); 
}
