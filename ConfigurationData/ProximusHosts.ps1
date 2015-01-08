# These variables are specfic settings for each target node that get applied to the DSC configiguration template
$ProximusHosts = @{ 
    AllNodes = @( 
        @{ 
            NodeName = "es-ssccm-01"
            Service = 'SCCM'
            Role = 'PrimarySite'
            DSLPath = 'E:\DSL'
        },

        @{ 
            NodeName = "es-ssccm-02"
            Service = 'SCCM'
            Role = 'ClientFacingSite'
        }
    ); 
}
