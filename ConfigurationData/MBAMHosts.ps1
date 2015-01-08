# These variables are specfic settings for each target node that get applied to the DSC configiguration template
$MBAMHosts = @{ 
    AllNodes = @( 
        @{ 
            NodeName = "es-smbam-01"
            Service = 'MBAM'
        }

    ); 
}
