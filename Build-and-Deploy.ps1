﻿######################################################################################
# This is the master Build and Deploy script.
# Common variables are defined here to call configurations and configuationdata which
# are then used to crate all MOF files, checksums, and have the entire process
# deployed to the Pull Server
######################################################################################

######################################################################################
# Master Variables
######################################################################################
$Configuration = "SCCMConfiguration"
$ConfigurationPath = "$env:HOMEDRIVE\DSC-Manager\Configuration"
$ConfigurationData = "ProximusHosts"
$ConfigurationDataPath = "$env:HOMEDRIVE\DSC-Manager\ConfigurationData"
$SourceModules = "$env:PROGRAMFILES\WindowsPowershell\Modules"
$PullServerModules = "$env:PROGRAMFILES\WindowsPowershell\DscService\Modules"
$PullServerConfiguration = "$env:PROGRAMFILES\WindowsPowershell\DscService\Configuration"
$PullServerCertStore = "$env:PROGRAMFILES\WindowsPowershell\DscService\NodeCertificates"
$PullServerNodeCSV = "$env:PROGRAMFILES\WindowsPowershell\DscService\Management\dscnodes.csv"
$PasswordData = "$env:PROGRAMFILES\WindowsPowershell\DscService\Management\passwords.xml"

######################################################################################
# Import DSC-Management
######################################################################################
if(!(Get-Module DSC-Management)) {
    Try {
        Import-Module ('.\core\DSC-Management.ps1')
        }
    Catch {
        Throw "Cannot load the DSC GUID and Certificate Management Tools.  Please make sure the module is present and try again"
        }
    }

######################################################################################
# Run DSC-Management functions
######################################################################################

#Update the CSV table with missing Server,GUID, and Thumbprint information
Update-DSCMTable -ConfigurationData $ConfigurationData -ConfigurationDataPath $ConfigurationDataPath -FileName $PullServerNodeCSV -CertStore $PullServerCertStore

#Load ConfigurationData then add thumbprint information if available for final configuration application
$UpdatedConfigurationData = Update-DSCMConfigurationData -ConfigurationData $ConfigurationData -ConfigurationDataPath $ConfigurationDataPath -FileName $PullServerNodeCSV

#Create All Configuration MOFs based on updated data and place in respective Pull Server Configuration
Update-DSCMPullServer -Configuration $Configuration -ConfigurationPath $ConfigurationPath -ConfigurationData $UpdatedConfigurationData -PasswordData $PasswordData -PullServerConfiguration $PullServerConfiguration

#Update Pull Server module repo with current modules from the local repo
Update-DSCMModules -SourceModules $SourceModules -PullServerModules $PullServerModules

######################################################################################
# Unload DSC-Management
######################################################################################
if(Get-Module DSC-Management) {
    Try {
        Remove-Module 'DSC-Management'
        }
    Catch {
        Throw "There was an error unloading the DSC-Management module!  Module may still be in memory"
        }
    }