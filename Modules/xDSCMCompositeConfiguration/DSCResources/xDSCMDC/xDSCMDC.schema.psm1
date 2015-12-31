Configuration xDSCMDC
{
    Param (
        [Parameter(Mandatory=$false)][String]$Role
    )

    WindowsFeature AD-Domain-Services {
            Ensure = "Present"
            Name   = "AD-Domain-Services"            
        }

    If ($Role -contains "PDC"){
        } #End If
}
