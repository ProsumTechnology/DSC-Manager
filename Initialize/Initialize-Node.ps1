Configuration SimpleMetaConfigurationForPull 
{ 

    Param(
        [Parameter(Mandatory=$False)][String]$NodeName = 'localhost',
        [Parameter(Mandatory=$False)][String]$NodeThumbprint,
        [Parameter(Mandatory=$True)][String]$NodeGUID
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
           DownloadManagerCustomData = (@{ServerUrl = "https://DSC.lab.transformingintoaservice.com:8080/PSDSCPullServer/PSDSCPullServer.svc"})
        }
     } 
}  

#Variables for the script placed up top to make it easier to change
$CertStore = "\\es-sdsc-01\c$\Program Files\WindowsPowershell\DscService\NodeCertificates"
$CSVFile = "\\es-sdsc-01\c$\Program Files\WindowsPowershell\DscService\Management\dscnodes.csv"
$GetName = $env:COMPUTERNAME

#Finds a certificate in the localmachine store with the latest expiration date
$BestCert = Get-Childitem cert:\LocalMachine\MY | Sort-Object NotAfter -Descending | Select -First 1
[bool]$CertNeedsUpdate = $false

#If no Files exist in the cert store with the computer name, mark to update
If(!(Test-Path -Path ($CertStore+'\'+$GetName+'.cer'))) {
    [bool]$CertNeedsUpdate = $true
    }

#If the file IS there, compare thumbprints and mark to update if they dont match.
Else {
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
        $DestinationFile = $CertStore+'\'+$GetName+'.cer'
        Export-Certificate -FilePath $DestinationFile -Cert $BESTCert
        }
    Catch {
        write-verbose "cannot write tot Certificate store $CertStore"
        }
    }

#Configures LCM
$csvdata = import-csv $CSVFile
$GetGUID = ($csvdata | where-object {$_."NodeName" -eq $env:COMPUTERNAME}).NodeGUID
If (!($GetGUID))
    {
    write "No GUID exists in the Pull Server!  Skipping..."
    }
Else
    {
    SimpleMetaConfigurationForPull -NodeGUID $GetGUID -NodeName $GetName -NodeThumbprint $BestCert.Thumbprint
    $FilePath = (Get-Location -PSProvider FileSystem).Path + "\SimpleMetaConfigurationForPull"
    Set-DscLocalConfigurationManager -ComputerName $GetName -Path $FilePath -Verbose
    }
