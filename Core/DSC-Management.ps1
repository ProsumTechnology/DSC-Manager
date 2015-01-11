#Creates the Certificate Store if missing.
function Create-DSCMCertStores
{
    param(
        [Parameter(Mandatory=$false)][String]$FileName = "$env:PROGRAMFILES\WindowsPowershell\DscService\Management\dscnodes.csv",
        [Parameter(Mandatory=$false)][String]$CertStore = "$env:PROGRAMFILES\WindowsPowershell\DscService\NodeCertificates",
        [switch]$TestOnly
        )

    [bool]$IsValid=$true

    If($CertStore -and !(Test-Path -Path ($CertStore)))
        {
        If ($TestOnly) {
            [bool]$isValid=$false
            }
        else {
            try {
                New-Item ($CertStore) -type directory -force -ErrorAction STOP
                }
            catch {
                $E = $_.Exception.GetBaseException()
                $E.ErrorInformation.Description
                }
            }
        }

    If($FileName -and !(Test-Path -Path ($FileName)))
        {
        If ($TestOnly) {
            [bool]$IsValid=$false
            }
        else {
            try {
                New-Item ($FileName) -type file -force -ErrorAction STOP
                $NewLine = "NodeName,NodeGUID,Thumbprint"
                $NewLine | add-content -path $FileName -ErrorAction STOP
                }
            catch {
                $E = $_.Exception.GetBaseException()
                $E.ErrorInformation.Description
                }
            }
        }
    If ($TestOnly) {return $IsValid}
}

#This function is to update and maintain the Host-to-GUID mapping table
function Update-DSCMTable
{
    param(
    [Parameter(Mandatory=$false)][String]$FileName = "$env:PROGRAMFILES\WindowsPowershell\DscService\Management\dscnodes.csv",
    [Parameter(Mandatory=$false)][String]$CertStore = "$env:PROGRAMFILES\WindowsPowershell\DscService\NodeCertificates",
    [Parameter(Mandatory=$false)][String]$ConfigurationDataPath = "$env:HOMEDRIVE\DSC-Manager\ConfigurationData",
    [Parameter(Mandatory)][ValidateNotNullOrEmpty()][String]$ConfigurationData
    )

    #Load Each ConfigurationData file found into memory and execute updates
    ForEach ($HashTable in $ConfigurationData) {
        Try {
            . $ConfigurationDataPath\$HashTable.ps1
            If ($CompiledData -eq $NULL) {
                Invoke-Expression "`$CompiledData = `$$HashTable"
                }
            Else {
                Invoke-Expression "`$CompiledData.AllNodes = `$CompiledData.AllNodes + `$$HashTable.AllNodes"
                }
            }
        Catch {
            Throw "Cannot find configuration data $Hashtable"
            }

        #Update CSVTable By calling other functions
        $CompiledData.AllNodes | ForEach-Object -Process {
            $CurrNode = $_.NodeName
            Update-DSCMGUIDMapping -NodeName $CurrNode -FileName $FileName -Silent
            Update-DSCMCertMapping -NodeName $CurrNode -FileName $FileName -CertStore $CertStore -Silent
            }
        }
}

#This function returns an updated hashtable with GUID and cert information
function Update-DSCMConfigurationData
{
    param(
    [Parameter(Mandatory=$false)][String]$FileName = "$env:PROGRAMFILES\WindowsPowershell\DscService\Management\dscnodes.csv",
    [Parameter(Mandatory=$false)][String]$CertStore = "$env:PROGRAMFILES\WindowsPowershell\DscService\NodeCertificates",
    [Parameter(Mandatory=$false)][String]$ConfigurationDataPath = "$env:HOMEDRIVE\DSC-Manager\ConfigurationData",
    [Parameter(Mandatory)][ValidateNotNullOrEmpty()][String]$ConfigurationData
    )

    #Load Each ConfigurationData file found into memory and execute updates
    $ReturnData = $Null
    ForEach ($HashTable in $ConfigurationData) {
        Try {
            . $ConfigurationDataPath\$HashTable.ps1
            If ($ReturnData -eq $NULL) {
                Invoke-Expression "`$ReturnData = `$$HashTable"
                }
            Else {
                Invoke-Expression "`$ReturnData.AllNodes = `$ReturnData.AllNodes + `$$HashTable.AllNodes"
                }
            }
        Catch {
            Throw "Cannot find configuration data $Hashtable"
            }
        }
        
        #Update ReturnData By calling other functions
        $ReturnData.AllNodes | ForEach-Object -Process {
            $CurrNode = $_.NodeName
            If (Update-DSCMGUIDMapping -NodeName $CurrNode -FileName $FileName) {
                $_.NodeName = (Update-DSCMGUIDMapping -NodeName $CurrNode -FileName $FileName)
                }
            if (Update-DSCMCertMapping -NodeName $CurrNode) {
                $_.Thumbprint = (Update-DSCMCertMapping -NodeName $CurrNode)
                $_.CertificateFile = $CertStore+'\'+$CurrNode+'.cer'
                }
            }
    return $ReturnData
}

#This function is to update and maintain the Host-to-GUID mapping to ease management.
function Update-DSCMGUIDMapping
{
    param(
    [Parameter(Mandatory=$false)][String]$FileName = "$env:PROGRAMFILES\WindowsPowershell\DscService\Management\dscnodes.csv",
    [Parameter(Mandatory)][ValidateNotNullOrEmpty()][String]$NodeName,
    [switch]$Silent
    )

    If (Create-DSCMCertStores -FileName $FileName -TestOnly) {
        $CSVFile = (import-csv $FileName)
        If(!($CSVFile | where-object {$_.NodeName -eq $NodeName})) {
            $NodeGUID = [guid]::NewGuid()
            $NewLine = "{0},{1}" -f $NodeName,$NodeGUID
            $NewLine | add-content -path $FileName
            }
        Else {
            $CSVFile | forEach-Object {
                If (($_.NodeName -eq $NodeName) -and !$_.NodeGUID) {
                    $NodeGUID = [guid]::NewGuid()
                    $_.NodeGUID = $NodeGUID
                    }
                ElseIf (($_.NodeName -eq $NodeName) -and $_.NodeGUID)  {
                    $NodeGUID = $_.NodeGuid
                    }
            If ($CSVFile -and !($CSVFile -eq (import-csv $Filename))) {
                $CSVFile | Export-CSV $FileName -Delimiter ','
                }
            }
        if(!($Silent)) {
            return,$NodeGUID
            }
        }
    }
    Else {
        write-verbose "the file $FileName cannot be found so there is nothing to return"
        }
 
}

#This function is to update and maintain the Certificate-to-host mapping to ease management
function Update-DSCMCertMapping
{
param(
    [Parameter(Mandatory=$false)][String]$FileName = "$env:PROGRAMFILES\WindowsPowershell\DscService\Management\dscnodes.csv",
    [Parameter(Mandatory=$false)][String]$CertStore = "$env:PROGRAMFILES\WindowsPowershell\DscService\NodeCertificates",
    [Parameter(Mandatory)][ValidateNotNullOrEmpty()][String]$NodeName,
    [switch]$Silent
    )

    If (Create-DSCMCertStores -FileName $FileName -CertStore $CertStore -TestOnly) {
        $CSVFile = import-csv $FileName
        
        #Check for existence of Certificate file
        $certfullpath = $CertStore+'\'+$NodeName+'.cer'
        If(Test-Path -Path ($certfullpath)) {
            
            # X509Certificate2 object that will represent the certificate
            $CertPrint = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
        
            # Imports the certificate from file to x509Certificate object
            $certPrint.Import($Certfullpath)
            $CSVFile | forEach-Object {
                If (($_.NodeName -eq $NodeName) -and !($_.Thumbprint -eq $certPrint.Thumbprint)) {
                    $_.Thumbprint = $CertPrint.Thumbprint
                    }                  
                }
            }

        #If the table was updated in the previous process, save it
        If($CSVFile -and !($CSVFile -eq (import-csv $Filename))) {
            $CSVFile | Export-CSV $FileName -Delimiter ','
            }
        
        #Query the table for the nodename and grab the thumbprint if present
        $CSVFile | forEach-Object {
            If ($_.NodeName -eq $NodeName) {
                $Thumbprint = $_.Thumbprint
                }
            }
        if(!($Silent)) {
            return,$Thumbprint
            }
        }

    Else {
        write-verbose "the file $FileName or $CertStore cannot be found so there is nothing to return"
        }
    }

#This function is automatically zip-up modules into the right format and place them into the DSC module folder
function New-DSCMResourceZip
{
    param
    (
        [Parameter(Mandatory=$true)][String]$modulePath,
        [Parameter(Mandatory=$false)][String]$outputDir="$env:PROGRAMFILES\WindowsPowershell\DscService\Modules"
    )
 
    # Read the module name & version
    
    $module = Import-Module $modulePath -PassThru
    $moduleName = $module.Name
    $version = $module.Version.ToString()
    Remove-Module $moduleName
 
    $zipFilename = ("{0}_{1}.zip" -f $moduleName, $version)
    $outputPath = Join-Path $outputDir $zipFilename
    if (Test-Path $outputPath) { del $outputPath }
 
    # Courtesy of: @Neptune443 (http://blog.cosmoskey.com/powershell/desired-state-configuration-in-pull-mode-over-smb/)
    [byte[]]$data = New-Object byte[] 22
    $data[0] = 80
    $data[1] = 75
    $data[2] = 5
    $data[3] = 6
    [System.IO.File]::WriteAllBytes($outputPath, $data)
    $acl = Get-Acl -Path $outputPath
 
    $shellObj = New-Object -ComObject "Shell.Application"
    $zipFileObj = $shellObj.NameSpace($outputPath)
    if ($zipFileObj -ne $null)
    {
        $target = get-item $modulePath
        # CopyHere might be async and we might need to wait for the Zip file to have been created full before we continue
        # Added flags to minimize any UI & prompts etc.
        $zipFileObj.CopyHere($target.FullName, 0x14)      
        [Runtime.InteropServices.Marshal]::ReleaseComObject($zipFileObj) | Out-Null
        Set-Acl -Path $outputPath -AclObject $acl
        New-DSCCheckSum -ConfigurationPath $outputDir
    }
    else
    {
        Throw "Failed to create the zip file"
    }
 
    return $outputPath
}

#This function is to import all certificates from the CertStore onto the local machine
function Update-DSCMImportallCerts
{
param(
    [Parameter(Mandatory=$false)][String]$CertStore = "$env:PROGRAMFILES\WindowsPowershell\DscService\NodeCertificates",
    [Parameter(Mandatory)][ValidateNotNullOrEmpty()][String]$NodeName
    )

    If (Create-DSCMCertStores -CertStore $CertStore -TestOnly) {
        $CertList = Get-ChildItem $CertStore
        
        #Verify every cert in the CertStore has been imported to all locations
        foreach ($cert in $certList) {

            # X509Certificate2 object that will represent the certificate
            $CertPrint = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
        
            # Imports the certificate from file to x509Certificate object
            $certPrint.Import($CertStore+'\'+$cert)
            if (!(Get-Childitem cert:\LocalMachine\MY | Where-Object {$_.Thumbprint -eq $certPrint.Thumbprint})) {
                $store = New-Object System.Security.Cryptography.X509Certificates.X509Store "MY", "LocalMachine"
                $store.Open("ReadWrite")
                $store.Add($certStore+'\'+$cert)
                $store.Close()
                }
            }
        }
    Else {
        write-verbose "the file $CertStore cannot be found so there is nothing to update"
        }
    }

#This function creates Variables storing credentials
Function Create-PasswordScriptVariable
{
param(
    [Parameter(Mandatory=$True)][String]$Name,
    [Parameter(Mandatory=$True)][String]$User,
    [Parameter(Mandatory=$True)][String]$Password
    )

    $SecurePass = ConvertTo-SecureString $Password -AsPlainText -Force
    Invoke-Expression ("`$Script:$Name = New-Object System.Management.Automation.PSCredential $User, `$SecurePass")
}

#This function is to create MOF files and copy them to the Pull Server from the specific working directory
function Update-DSCMPullServer 
{
param(
    [Parameter(Mandatory=$true)][String]$Configuration,
    [Parameter(Mandatory=$true)][HashTable]$ConfigurationData,
    [Parameter(Mandatory=$false)][String]$PasswordData = "$env:PROGRAMFILES\WindowsPowershell\DscService\Management\passwords.xml",
    [Parameter(Mandatory=$false)][String]$ConfigurationPath = "$env:HOME\DSC-Manager\Configuration",
    [Parameter(Mandatory=$false)][String]$PullServerConfiguration = "$env:PROGRAMFILES\WindowsPowershell\DscService\Configuration",
    [Parameter(Mandatory=$false)][String]$WorkingPath = $env:TEMP
    )

    #Load DSC Configuration into script
    Write-Verbose -Message "Loading DSC Configuration..."
    Try {
        Invoke-Expression ". $ConfigurationPath\$Configuration.ps1"
        }
    Catch {
        Throw "error loading DSC Configuration $ConfigurationPath\$Configuration.ps1"
        }

    #Generate Password Variables from PasswordData
    Write-Verbose -Message "Loading Passwords into secure string variables..."
    $Config = [XML] (Get-Content "$PasswordData")
    $Config.Credentials | ForEach-Object {$_.Variable} | Where-Object {$_.Name -ne $null} | ForEach-Object {Create-PasswordScriptVariable -Name $_.Name -User $_.User -Password $_.Password}

    #generate MOF files using Configurationdata and output to the appropriate temporary path
    Write-Verbose -Message "Generating MOF using Configurationdata and output to $WorkingPath..."
    invoke-expression "$Configuration -ConfigurationData `$ConfigurationData -outputpath $WorkingPath"

    #create a checksum file for eah generated MOF
    Write-Verbose -Message "Generating checksum..."
    New-DSCCheckSum -ConfigurationPath $WorkingPath -OutPath $WorkingPath -Verbose -Force
    
    #All Generation is complete, now we copy it all to the Pull Server
    Write-Verbose -Message "Moving all files to $PullServerConfiguration..."
    $SourceFiles = $WorkingPath + "\*.mof*"
    Move-Item $SourceFiles $PullServerConfiguration -Force
}
