param (
    [Parameter(Mandatory=$true)][String]$Thumbprint,
    [Parameter(Mandatory=$false)][String]$NodeName = "localhost",
    [Parameter(Mandatory=$false)][String]$PowerShellGetInstaller,
    [Parameter(Mandatory=$false)][Switch]$WhatIf = $false
    )

#Configuration Data For PullServer Install$configData = @{    AllNodes = @(        @{            NodeName = "*"            PSDscAllowPlainTextPassword = $true         },         @{            NodeName = $NodeName            Role = "DSCPullServer"            Source = $PowerShellGetInstaller            CertificateThumbPrint = $Thumbprint         }    );}

#amends module path
$originalpaths = (Get-ItemProperty -Path ‘Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment’ -Name PSModulePath).PSModulePath
$newPath=$originalpaths+’;C:\DSC-Manager\Modules’
Set-ItemProperty -Path ‘Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment’ -Name PSModulePath –Value $newPath

#This imports the DSC Management functions.  This helps manage Certificate and GUID mappings
if(!(Get-Module DSCManager)) {
    Try {
        Import-Module DSCManager
        }
    Catch {
        Throw "Trying to load Management tools but failing."
        }
    }

#Use PowerShellGet to to download xPSDersiredState if it's missing
install-module xPSDesiredStateConfiguration

#DSC Configuration
configuration DSC_PullServer {

    Import-DSCResource -ModuleName xPSDesiredStateConfiguration

    Node $AllNodes.where{ $_.Role.Contains("DSCPullServer") }.NodeName
    {
        WindowsFeature DSCServiceFeature
        {
            Ensure = "Present"
            Name   = "DSC-Service"            
        }

        WindowsFeature WindowsAuth
        {
            Ensure = "Present"
            Name   = "web-windows-auth"            
        }

        WindowsFeature IISTools
        {
            Ensure = "Present"
            Name   = "Web-Mgmt-Console"            
        }

        Script InstallPowerShellGet
        {
            GetScript = {
                $Name = (get-module PowerShellGet -ListAvailable).Name
                $Version =(get-module PowerShellGet -ListAvailable).Name.Major
                $Return =  @{
                    Name = $Name;
                    Version = $Version;
                    }
                $Return
                } #End GetScript

            SetScript = {
                If (!(get-module PowerShellGet -ListAvailable)) {
                    If (($PSVersionTable.PSVersion.Major -eq 4) -or ($PSVersionTable.PSVersion.Major -eq 3)) {
                        $cmd = 'msiexec /package '+$Source+'\PackageManagement_x64.msi /quiet'
                        Invoke-Expression $cmd
                        Get-PackageProvider -Name NuGet -ForceBootstrap
                        } #End PSV4 Upgrade
                    Else {
                        write-verbose "can't find PowerShellGet.  Please Address" 
                        } #End Else
                    } #End Install Missing Module
                } #End SetScript

            TestScript = {
                $Name = (get-module PowerShellGet -ListAvailable).Name
                If ($Name -ne $Null) {$IsInstalled = $True}
                Else {$IsInstalled = $False}
                $IsInstalled
                }
        } #End InstallPowerShellGet

        xDscWebService PSDSCPullServer
        {
            Ensure                  = "Present"
            EndpointName            = "PSDSCPullServer"
            Port                    = 8080
            PhysicalPath            = "$env:SystemDrive\inetpub\PSDSCPullServer"
            CertificateThumbPrint   = $Node.CertificateThumbPrint         
            ModulePath              = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Modules"
            ConfigurationPath       = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration"            
            State                   = "Started"
            DependsOn               = "[WindowsFeature]DSCServiceFeature"                        
        }

        xDscWebService PSDSCComplianceServer
        {
            Ensure                  = "Present"
            EndpointName            = "PSDSCComplianceServer"
            Port                    = 9080
            PhysicalPath            = "$env:SystemDrive\inetpub\PSDSCComplianceServer"
            CertificateThumbPrint   = "AllowUnencryptedTraffic"
            State                   = "Started"
            IsComplianceServer      = $true
            DependsOn               = @("[WindowsFeature]DSCServiceFeature","[xDSCWebService]PSDSCPullServer")
        }
    }
 } #End DSC_PullServer

DSC_PullServer -ConfigurationData $ConfigData
Start-DscConfiguration -wait -verbose .\DSC_PullServer -force

Install-DSCMCertStores
