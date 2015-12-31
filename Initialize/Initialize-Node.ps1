param (
    [Parameter(Mandatory=$true)][String]$PullServer,
    [Parameter(Mandatory=$false)][String]$CertStore,
    [Parameter(Mandatory=$false)][String]$AgentRegistration,
    [Parameter(Mandatory=$false)][Switch]$WhatIf = $false
    )

#Set and Test parameter validate
If (!($CertStore)) {$CertStore = "\\$PullServer\CertStore"}

Try {
    Write-Verbose "test writing to $CertStore ..."
    new-item "$CertStore\test.txt" -ItemType File | Out-Null
    remove-item "$CertStore\test.txt"
    }
Catch {
    Throw "can't write to $CertStore..."
    }

If (!($AgentRegistration)) {$AgentRegistration = "\\$PullServer\AgentRegistration"}
Try {
    Write-Verbose "test writing to $AgentRegistration ..."
    new-item "$AgentRegistration\test.txt" -ItemType File | Out-Null
    remove-item "$AgentRegistration\test.txt"
    }
Catch {
    Throw "can't write to $AgentRegistration..."
    }

#Gather list of local variables needed
$GetName = $env:COMPUTERNAME
[bool]$CertNeedsUpdate = $False
$BestCert = Get-Childitem cert:\LocalMachine\MY | Sort-Object NotAfter -Descending | Select -First 1


#If no Files exist in the cert store with the computer name, mark to update
If(!(Test-Path -Path ($CertStore+'\'+$GetName+'.cer'))) {
    write-verbose "certificate doesn't apear to exist..."
    [bool]$CertNeedsUpdate = $true
    }

#If the file IS there, compare thumbprints and mark to update if they dont match.
Else {
    write-verbose "cert found, comparing thumbprints"
    # X509Certificate2 object that will represent the certificate
    $CertPrint = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
     
    # Imports the certificate from file to x509Certificate object
    $certPrint.Import($CertStore+'\'+$GetName+'.cer')

    #Set Flag to Update if Thumbprints dont match
    If(!($CertPrint.Thumbprint -eq $BestCert.Thumbprint)) {[bool]$CertNeedsUpdate = $true}
    }

#If the certificate needs to be updated, do it now
IF(($CertNeedsUpdate -eq $true) -and $BestCert) {
    Try {
        write-verbose "Attempting to write to $CertStore\$GetName"
        $DestinationFile = $CertStore+'\'+$GetName+'.cer'
        Export-Certificate -FilePath $DestinationFile -Cert $BestCert
        }
    Catch {
        Throw "cannot write "+$DestinationFile
        }
    }

#Add blank request if it doesn't exist then exist
If(!(Test-Path -Path ($AgentRegistration+'\'+$GetName+'.txt'))) {
    new-item "$AgentRegistration\$GetName.txt" -ItemType File
    write-verbose "created new request, exiting"
    exit
    }

#Check for GUID in file if file is present
Else {
    $GetGUID = Get-Content "$AgentRegistration\$GetName.txt"
    IF (!($GetGUID)) {
        write-verbose "No authorization GUID, there is nothing to do"
        Exit
        }
    try {[guid]$getguid}
    catch {Throw "can't translate $GetGUID in to a valid GUID"}
    }

#Failsafe.  Kill the script if no GUID has been presented yet
IF (!($GetGUID)) {Exit}

#Compile Configuration for install
Configuration SimpleMetaConfigurationForPull 
{ 

    Param(
        [Parameter(Mandatory=$False)][String]$NodeName = 'localhost',
        [Parameter(Mandatory=$False)][String]$NodeThumbprint,
        [Parameter(Mandatory=$True)][String]$NodeGUID,
        [Parameter(Mandatory=$True)][String]$PullServerURL
          )
    Node $NodeName
    {
     LocalConfigurationManager 
        { 
           ConfigurationID = $NodeGUID;
           CertificateId = $NodeThumbprint;
           RefreshMode = "PULL";
           DownloadManagerName = "WebDownloadManager";
           RebootNodeIfNeeded = $true;
           AllowModuleOverwrite = $true;
           RefreshFrequencyMins = 15;
           ConfigurationModeFrequencyMins = 30; 
           ConfigurationMode = "ApplyAndAutoCorrect";
           DownloadManagerCustomData = (@{ServerUrl = $PullServerURL})
        }
     } 
}  

#Configures LCM
Try {
    $PullServerURL = 'https://'+$PullServer+':8080/PSDSCPullServer/PSDSCPullServer.svc'
    SimpleMetaConfigurationForPull -NodeGUID $GetGUID -NodeName $GetName -NodeThumbprint $BestCert.Thumbprint -PullServerURL $PullServerURL
    $FilePath = (Get-Location -PSProvider FileSystem).Path + "\SimpleMetaConfigurationForPull"
    Set-DscLocalConfigurationManager -ComputerName $GetName -Path $FilePath -Verbose
    }
Catch {
    Throw "Cannot configure LCM.  Exiting ..."
    }