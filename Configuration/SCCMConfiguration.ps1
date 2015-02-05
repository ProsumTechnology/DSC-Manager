Configuration SCCMConfiguration
{ 
    #param 
    #(
    #    [Parameter(Mandatory=$true)][ValidateNotNullorEmpty()][PsCredential]$SCCMAdministratorCredential
    #)
    
    Import-DSCResource -ModuleName cSCCM
    
    Node $AllNodes.Where{$_.Service -eq "SCCM" -and $_.Role -eq "PrimarySite" }.NodeName 
    {
        cCMFolder Device_All
        { 
            FolderName = "_All"
            FolderType = "Device Collection"
            ParentFolder = "Root"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMFolder User_All
        { 
            FolderName = "_All"
            FolderType = "User Collection"
            ParentFolder = "Root"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        } 

        cCMFolder DeviceSystems
        { 
            FolderName = "Systems"
            FolderType = "Device Collection"
            ParentFolder = "Root"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        } 
   
        cCMFolder DeviceSystemsType
        { 
            FolderName = "Systems - Type"
            FolderType = "Device Collection"
            ParentFolder = "Systems"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }
        
        cCMFolder DeviceSystemsLocation
        { 
            FolderName = "Systems - Location"
            FolderType = "Device Collection"
            ParentFolder = "Systems"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        } 
        
        cCMFolder DeviceSystemsDepartment
        { 
            FolderName = "Systems - Department"
            FolderType = "Device Collection"
            ParentFolder = "Systems"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }  

         cCMFolder DeviceEndpointProtection
        { 
            FolderName = "Endpoint Protection"
            FolderType = "Device Collection"
            ParentFolder = "Root"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        } 

         cCMFolder DeviceSoftwareUpdates
        { 
            FolderName = "Software Updates"
            FolderType = "Device Collection"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            ParentFolder = "Root"
            Ensure = "Present"
        } 

        cCMFolder DeviceServerUpdates
        { 
            FolderName = "Software Updates - Servers"
            FolderType = "Device Collection"
            ParentFolder = "Software Updates"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        } 


        cCMFolder DeviceWorkstationUpdates
        { 
            FolderName = "Software Updates - Workstations"
            FolderType = "Device Collection"
            ParentFolder = "Software Updates"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }
        
        cCMFolder DeviceOSD
        { 
            FolderName = "Operating System Deployment"
            FolderType = "Device Collection"
            ParentFolder = "Root"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        } 
        
        cCMFolder DevicePowerProfile
        { 
            FolderName = "Power Profile"
            FolderType = "Device Collection"
            ParentFolder = "Root"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        } 

        cCMFolder DeviceApplications
        { 
            FolderName = "Applications"
            FolderType = "Device Collection"
            ParentFolder = "Root"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        } 

        cCMFolder UserApplications
        { 
            FolderName = "Applications"
            FolderType = "User Collection"
            ParentFolder = "Root"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        } 
        
        cCMFolder DriverPWindows8_x64
        { 
            FolderName = "Windows_8_x64"
            FolderType = "Driver Package"
            ParentFolder = "Root"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMFolder DriverPWindows7_x64
        { 
            FolderName = "Windows_7_x64"
            FolderType = "Driver Package"
            ParentFolder = "Root"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMFolder DriverMicrosoft
        { 
            FolderName = "Microsoft"
            FolderType = "Driver"
            ParentFolder = "Root"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMFolder DriverHyperV
        { 
            FolderName = "Hyper-V"
            FolderType = "Driver"
            ParentFolder = "Microsoft"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMFolder DriverWindows8_x64
        { 
            FolderName = "Windows_8_x64"
            FolderType = "Driver"
            ParentFolder = "Hyper-V"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMFolder DriverWindows7_x64
        { 
            FolderName = "Windows_7_x64"
            FolderType = "Driver"
            ParentFolder = "Hyper-V"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMFolder ImagesDeployment
        { 
            FolderName = "Deployment Ready Images"
            FolderType = "Image Package"
            ParentFolder = "Root"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMFolder ImagesReference
        { 
            FolderName = "Reference Images"
            FolderType = "Image Package"
            ParentFolder = "Root"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMFolder SeqBuild
        { 
            FolderName = "Build Sequences"
            FolderType = "Task Sequence"
            ParentFolder = "Root"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMFolder SeqDeploy
        { 
            FolderName = "Deployment Sequences"
            FolderType = "Task Sequence"
            ParentFolder = "Root"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMFolder SeqGeneral
        { 
            FolderName = "General Task Sequences"
            FolderType = "Task Sequence"
            ParentFolder = "Root"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection DeviceAllWorkstations
        { 
            CollectionName = "All Workstations"
		    LimitingCollectionName = "All Systems"
		    ParentFolder = "Root"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }
        
        cCMCollectionRule DeviceAllWorkstationsQuery
        {
            RuleName = 'Windows Workstations'
            ParentCollection = 'All Workstations'
            ParentCollectionType = 'Device'
            QueryType = 'Query'
            QueryExpression = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.OperatingSystemNameandVersion LIKE "%Workstation%"'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        } 

        cCMCollection DeviceAllServers
        { 
            CollectionName = "All Servers"
		    LimitingCollectionName = "All Systems"
		    ParentFolder = "Root"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule DeviceAllServersQuery
        {
            RuleName = 'Windows Servers'
            ParentCollection = 'All Servers'
            ParentCollectionType = 'Device'
            QueryType = 'Query'
            QueryExpression = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.OperatingSystemNameandVersion LIKE "%Server%"'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        } 

        cCMCollection DeviceAllWin7
        { 
            CollectionName = "Systems - Type - Windows 7 Workstations"
		    LimitingCollectionName = "All Workstations"
		    ParentFolder = "Systems - Type"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Both"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule DeviceAllWin7Query
        {
            RuleName = 'Windows 7 Clients'
            ParentCollection = 'Systems - Type - Windows 7 Workstations'
            ParentCollectionType = 'Device'
            QueryType = 'Query'
            QueryExpression = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.OperatingSystemNameandVersion LIKE "%Workstation 6.1%"'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection DeviceAllWin8
        { 
            CollectionName = "Systems - Type - Windows 8 Workstations"
		    LimitingCollectionName = "All Workstations"
		    ParentFolder = "Systems - Type"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Both"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }
        
        cCMCollectionRule DeviceAllWin8Query
        {
            RuleName = 'Windows 8 Clients'
            ParentCollection = 'Systems - Type - Windows 8 Workstations'
            ParentCollectionType = 'Device'
            QueryType = 'Query'
            QueryExpression = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.OperatingSystemNameandVersion LIKE "%Workstation 6.2%"'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection DeviceAllWin81
        { 
            CollectionName = "Systems - Type - Windows 8.1 Workstations"
		    LimitingCollectionName = "All Workstations"
		    ParentFolder = "Systems - Type"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Both"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule DeviceAllWin81Query
        {
            RuleName = 'Windows 8.1 Clients'
            ParentCollection = 'Systems - Type - Windows 8.1 Workstations'
            ParentCollectionType = 'Device'
            QueryType = 'Query'
            QueryExpression = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.OperatingSystemNameandVersion LIKE "%Workstation 6.3%"'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection DeviceAllWinXP
        { 
            CollectionName = "Systems - Type - Windows XP Workstations"
		    LimitingCollectionName = "All Workstations"
		    ParentFolder = "Systems - Type"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Both"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule DeviceAllWinXPQuery
        {
            RuleName = 'Windows XP Clients'
            ParentCollection = 'Systems - Type - Windows XP Workstations'
            ParentCollectionType = 'Device'
            QueryType = 'Query'
            QueryExpression = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.OperatingSystemNameandVersion LIKE "%Workstation 5.1%"'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection DeviceAllSCCM
        { 
            CollectionName = "Systems - Type - ConfigManager Servers"
		    LimitingCollectionName = "All Servers"
		    ParentFolder = "Systems - Type"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Both"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule DeviceAllSCCMQuery
        {
            RuleName = 'Query SCCM Roles'
            ParentCollection = 'Systems - Type - ConfigManager Servers'
            ParentCollectionType = 'Device'
            QueryType = 'Query'
            QueryExpression = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.SystemRoles IS NOT NULL'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection DeviceAll2008
        { 
            CollectionName = "Systems - Type - Windows 2008 Servers"
		    LimitingCollectionName = "All Servers"
		    ParentFolder = "Systems - Type"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Both"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule DeviceAll2008Query
        {
            RuleName = '2008 Name Query'
            ParentCollection = 'Systems - Type - Windows 2008 Servers'
            ParentCollectionType = 'Device'
            QueryType = 'Query'
            QueryExpression = 'select SMS_R_System.ResourceId, SMS_R_System.ResourceType, SMS_R_System.Name, SMS_R_System.SMSUniqueIdentifier, SMS_R_System.ResourceDomainORWorkgroup, SMS_R_System.Client from  SMS_R_System where SMS_R_System.OperatingSystemNameandVersion LIKE "%Server 6.0%"'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection DeviceAll2008R2
        { 
            CollectionName = "Systems - Type - Windows 2008 R2 Servers"
		    LimitingCollectionName = "All Servers"
		    ParentFolder = "Systems - Type"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Both"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule DeviceAll2008R2Query
        {
            RuleName = '2008 R2 Name Query'
            ParentCollection = 'Systems - Type - Windows 2008 R2 Servers'
            ParentCollectionType = 'Device'
            QueryType = 'Query'
            QueryExpression = 'select SMS_R_System.ResourceId, SMS_R_System.ResourceType, SMS_R_System.Name, SMS_R_System.SMSUniqueIdentifier, SMS_R_System.ResourceDomainORWorkgroup, SMS_R_System.Client from  SMS_R_System where SMS_R_System.OperatingSystemNameandVersion LIKE "%Server 6.1%"'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection DeviceAll2012
        { 
            CollectionName = "Systems - Type - Windows 2012 Servers"
		    LimitingCollectionName = "All Servers"
		    ParentFolder = "Systems - Type"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Both"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule DeviceAll2012Query
        {
            RuleName = '2012 Name Query'
            ParentCollection = 'Systems - Type - Windows 2012 Servers'
            ParentCollectionType = 'Device'
            QueryType = 'Query'
            QueryExpression = 'select SMS_R_System.ResourceId, SMS_R_System.ResourceType, SMS_R_System.Name, SMS_R_System.SMSUniqueIdentifier, SMS_R_System.ResourceDomainORWorkgroup, SMS_R_System.Client from  SMS_R_System where SMS_R_System.OperatingSystemNameandVersion LIKE "%Server 6.2%"'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection DeviceAll2012R2
        { 
            CollectionName = "Systems - Type - Windows 2012 R2 Servers"
		    LimitingCollectionName = "All Servers"
		    ParentFolder = "Systems - Type"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Both"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule DeviceAll2012R2Query
        {
            RuleName = '2012 R2 Name Query'
            ParentCollection = 'Systems - Type - Windows 2012 R2 Servers'
            ParentCollectionType = 'Device'
            QueryType = 'Query'
            QueryExpression = 'select SMS_R_System.ResourceId, SMS_R_System.ResourceType, SMS_R_System.Name, SMS_R_System.SMSUniqueIdentifier, SMS_R_System.ResourceDomainORWorkgroup, SMS_R_System.Client from  SMS_R_System where SMS_R_System.OperatingSystemNameandVersion LIKE "%Server 6.3%"'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection DeviceDCs
        { 
            CollectionName = "Systems - Type - Domain Controllers"
		    LimitingCollectionName = "All Servers"
		    ParentFolder = "Systems - Type"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Both"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule DeviceDCsQuery
        {
            RuleName = 'DC Role Query'
            ParentCollection = 'Systems - Type - Domain Controllers'
            ParentCollectionType = 'Device'
            QueryType = 'Query'
            QueryExpression = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System inner join SMS_G_System_COMPUTER_SYSTEM on SMS_G_System_COMPUTER_SYSTEM.ResourceId = SMS_R_System.ResourceId where SMS_G_System_COMPUTER_SYSTEM.Roles like "%Domain_Controller%"'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection DeviceDNSServers
        { 
            CollectionName = "Systems - Type - DNS Servers"
		    LimitingCollectionName = "All Servers"
		    ParentFolder = "Systems - Type"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Both"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule DeviceDNSQuery
        {
            RuleName = 'DNS Role Query'
            ParentCollection = 'Systems - Type - DNS Servers'
            ParentCollectionType = 'Device'
            QueryType = 'Query'
            QueryExpression = 'select * from SMS_R_System inner join SMS_G_System_SERVICE on SMS_G_System_SERVICE.ResourceID = SMS_R_System.ResourceId where SMS_G_System_SERVICE.DisplayName = "DNS Server" and SMS_G_System_SERVICE.StartMode = "Auto"'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection DeviceDHCPServers
        { 
            CollectionName = "Systems - Type - DHCP Servers"
		    LimitingCollectionName = "All Servers"
		    ParentFolder = "Systems - Type"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Both"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule DeviceDHCPQuery
        {
            RuleName = 'DHCP Role Query'
            ParentCollection = 'Systems - Type - DHCP Servers'
            ParentCollectionType = 'Device'
            QueryType = 'Query'
            QueryExpression = 'select * from SMS_R_System inner join SMS_G_System_SERVICE on SMS_G_System_SERVICE.ResourceID = SMS_R_System.ResourceId where SMS_G_System_SERVICE.DisplayName = "DHCP Server" and SMS_G_System_SERVICE.StartMode = "Auto"'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection HyperVServers
        { 
            CollectionName = "Systems - Type - Hyper-V Servers"
		    LimitingCollectionName = "All Servers"
		    ParentFolder = "Systems - Type"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Both"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule HyperVServersQuery
        {
            RuleName = 'Hyper-V Role Query'
            ParentCollection = 'Systems - Type - Hyper-V Servers'
            ParentCollectionType = 'Device'
            QueryType = 'Query'
            QueryExpression = 'select * from SMS_R_System inner join SMS_G_System_SERVICE on SMS_G_System_SERVICE.ResourceID = SMS_R_System.ResourceId where SMS_G_System_SERVICE.DisplayName = "Hyper-V Virtual Machine Management" and SMS_G_System_SERVICE.StartMode = "Auto"'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection EndpointDeploymentWS
        { 
            CollectionName = "Endpoint Deployment"
		    LimitingCollectionName = "All Desktop and Server Clients"
		    ParentFolder = "Endpoint Protection"
		    CollectionType = "Device"
            RefreshDays = "1"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule EndpointDeploymentWSQueryinc1
        {
            RuleName = 'Systems - Type - Windows 7 Workstations'
            ParentCollection = 'Endpoint Deployment'
            ParentCollectionType = 'Device'
            QueryType = 'Include'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule EndpointDeploymentWSQueryinc2
        {
            RuleName = 'Systems - Type - Windows 8 Workstations'
            ParentCollection = 'Endpoint Deployment'
            ParentCollectionType = 'Device'
            QueryType = 'Include'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule EndpointDeploymentWSQueryinc3
        {
            RuleName = 'Systems - Type - Windows 8.1 Workstations'
            ParentCollection = 'Endpoint Deployment'
            ParentCollectionType = 'Device'
            QueryType = 'Include'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule EndpointDeploymentWSQueryinc4
        {
            RuleName = 'Systems - Type - Windows XP Workstations'
            ParentCollection = 'Endpoint Deployment'
            ParentCollectionType = 'Device'
            QueryType = 'Include'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection EndpointPolicyDesktop
        { 
            CollectionName = "Endpoint Policy - Standard Desktop"
		    LimitingCollectionName = "All Workstations"
		    ParentFolder = "Endpoint Protection"
		    CollectionType = "Device"
            RefreshDays = "1"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule EndpointPolicyDesktopQueryinc1
        {
            RuleName = 'Systems - Type - Windows 7 Workstations'
            ParentCollection = 'Endpoint Policy - Standard Desktop'
            ParentCollectionType = 'Device'
            QueryType = 'Include'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule EndpointPolicyDesktopQueryinc2
        {
            RuleName = 'Systems - Type - Windows 8 Workstations'
            ParentCollection = 'Endpoint Policy - Standard Desktop'
            ParentCollectionType = 'Device'
            QueryType = 'Include'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule EndpointPolicyDesktopQueryinc3
        {
            RuleName = 'Systems - Type - Windows 8.1 Workstations'
            ParentCollection = 'Endpoint Policy - Standard Desktop'
            ParentCollectionType = 'Device'
            QueryType = 'Include'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule EndpointPolicyDesktopQueryinc4
        {
            RuleName = 'Systems - Type - Windows XP Workstations'
            ParentCollection = 'Endpoint Policy - Standard Desktop'
            ParentCollectionType = 'Device'
            QueryType = 'Include'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection EndpointPolicyServer
        { 
            CollectionName = "Endpoint Policy - Standard Server"
		    LimitingCollectionName = "All Servers"
		    ParentFolder = "Endpoint Protection"
		    CollectionType = "Device"
            RefreshDays = "1"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule EndpointPolicyServerQueryinc1
        {
            RuleName = 'Systems - Type - Windows 2008 Servers'
            ParentCollection = 'Endpoint Policy - Standard Server'
            ParentCollectionType = 'Device'
            QueryType = 'Include'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule EndpointPolicyServerQueryinc2
        {
            RuleName = 'Systems - Type - Windows 2008 R2 Servers'
            ParentCollection = 'Endpoint Policy - Standard Server'
            ParentCollectionType = 'Device'
            QueryType = 'Include'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule EndpointPolicyServerQueryinc3
        {
            RuleName = 'Systems - Type - Windows 2012 Servers'
            ParentCollection = 'Endpoint Policy - Standard Server'
            ParentCollectionType = 'Device'
            QueryType = 'Include'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule EndpointPolicyServerQueryinc4
        {
            RuleName = 'Systems - Type - Windows 2012 R2 Servers'
            ParentCollection = 'Endpoint Policy - Standard Server'
            ParentCollectionType = 'Device'
            QueryType = 'Include'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection EndpointPolicyCM
        { 
            CollectionName = "Endpoint Policy - ConfigManager"
		    LimitingCollectionName = "All Servers"
		    ParentFolder = "Endpoint Protection"
		    CollectionType = "Device"
            RefreshDays = "1"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule EndpointPolicyCMQueryinc1
        {
            RuleName = 'Systems - Type - ConfigManager Servers'
            ParentCollection = 'Endpoint Policy - ConfigManager'
            ParentCollectionType = 'Device'
            QueryType = 'Include'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection EndpointPolicyDC
        { 
            CollectionName = "Endpoint Policy - Domain Controller"
		    LimitingCollectionName = "All Servers"
		    ParentFolder = "Endpoint Protection"
		    CollectionType = "Device"
            RefreshDays = "1"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule EndpointPolicyDCQueryinc1
        {
            RuleName = 'Systems - Type - Domain Controllers'
            ParentCollection = 'Endpoint Policy - Domain Controller'
            ParentCollectionType = 'Device'
            QueryType = 'Include'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection EndpointPolicyDHCP
        { 
            CollectionName = "Endpoint Policy - DHCP"
		    LimitingCollectionName = "All Servers"
		    ParentFolder = "Endpoint Protection"
		    CollectionType = "Device"
            RefreshDays = "1"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule EndpointPolicyDHCPQueryinc1
        {
            RuleName = 'Systems - Type - DHCP Servers'
            ParentCollection = 'Endpoint Policy - DHCP'
            ParentCollectionType = 'Device'
            QueryType = 'Include'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection EndpointPolicyDNS
        { 
            CollectionName = "Endpoint Policy - DNS"
		    LimitingCollectionName = "All Servers"
		    ParentFolder = "Endpoint Protection"
		    CollectionType = "Device"
            RefreshDays = "1"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule EndpointPolicyDNSQueryinc1
        {
            RuleName = 'Systems - Type - DNS Servers'
            ParentCollection = 'Endpoint Policy - DNS'
            ParentCollectionType = 'Device'
            QueryType = 'Include'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection EndpointPolicyDHyperV
        { 
            CollectionName = "Endpoint Policy - Hyper-V"
		    LimitingCollectionName = "All Servers"
		    ParentFolder = "Endpoint Protection"
		    CollectionType = "Device"
            RefreshDays = "1"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule EndpointPolicyHyperVQueryinc1
        {
            RuleName = 'Systems - Type - Hyper-V Servers'
            ParentCollection = 'Endpoint Policy - Hyper-V'
            ParentCollectionType = 'Device'
            QueryType = 'Include'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection SUPWorkstationMW
        { 
            CollectionName = "Software Updates - Workstations - Maintenance Window"
		    LimitingCollectionName = "All Workstations"
		    ParentFolder = "Software Updates - Workstations"
		    CollectionType = "Device"
		    RefreshDays = "1"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollectionRule SUPWorkstationMWQuery
        {
            RuleName = 'Grab All'
            ParentCollection = 'Software Updates - Workstations - Maintenance Window'
            ParentCollectionType = 'Device'
            QueryType = 'Query'
            QueryExpression = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System'
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection SUPServersAD
        { 
            CollectionName = "Software Updates - Servers - AD Services"
		    LimitingCollectionName = "All Servers"
		    ParentFolder = "Software Updates - Servers"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection SUPServersDB
        { 
            CollectionName = "Software Updates - Servers - Database Services"
		    LimitingCollectionName = "All Servers"
		    ParentFolder = "Software Updates - Servers"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection SUPServersGeneral
        { 
            CollectionName = "Software Updates - Servers - General"
		    LimitingCollectionName = "All Servers"
		    ParentFolder = "Software Updates - Servers"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection SUPServersWeb
        { 
            CollectionName = "Software Updates - Servers - Web Services"
		    LimitingCollectionName = "All Servers"
		    ParentFolder = "Software Updates - Servers"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection SUPServersmail
        { 
            CollectionName = "Software Updates - Servers - Mail Services"
		    LimitingCollectionName = "All Servers"
		    ParentFolder = "Software Updates - Servers"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

         cCMCollection OSDAppStage
        { 
            CollectionName = "OSD - Application Staging"
		    LimitingCollectionName = "All Systems"
		    ParentFolder = "Operating System Deployment"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection OSDWin7Capture
        { 
            CollectionName = "OSD - Windows 7 Build and Capture"
		    LimitingCollectionName = "All Systems"
		    ParentFolder = "Operating System Deployment"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection OSDWin81Capture
        { 
            CollectionName = "OSD - Windows 8.1 Build and Capture"
		    LimitingCollectionName = "All Systems"
		    ParentFolder = "Operating System Deployment"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection OSDDeployment
        { 
            CollectionName = "OSD - Master Deployment"
		    LimitingCollectionName = "All Systems"
		    ParentFolder = "Operating System Deployment"
		    CollectionType = "Device"
		    RefreshDays = "7"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection PPBalanced
        { 
            CollectionName = "Power Profile - Balanced"
		    LimitingCollectionName = "All Workstations"
		    ParentFolder = "Power Profile"
		    CollectionType = "Device"
		    RefreshDays = "1"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection PPHighPerf
        { 
            CollectionName = "Power Profile - High Performance"
		    LimitingCollectionName = "All Workstations"
		    ParentFolder = "Power Profile"
		    CollectionType = "Device"
		    RefreshDays = "1"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection PPPwrSaver
        { 
            CollectionName = "Power Profile - Power Saver"
		    LimitingCollectionName = "All Workstations"
		    ParentFolder = "Power Profile"
		    CollectionType = "Device"
		    RefreshDays = "1"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

        cCMCollection PPVServer
        { 
            CollectionName = "Power Profile - Custom"
		    LimitingCollectionName = "All Workstations"
		    ParentFolder = "Power Profile"
		    CollectionType = "Device"
		    RefreshDays = "1"
		    RefreshType = "Periodic"
            SCCMAdministratorCredential = $SCCMAdministratorCredential
            Ensure = "Present"
        }

    }

    Node $AllNodes.Where{$_.Service -eq "SCCM" -and $_.DSLPath -ne $NULL}.NodeName 
    {

        File DSLApplications
        {
            Type = 'Directory'
            DestinationPath = $Node.DSLPath + '\Application_Management\Applications'
            Ensure = 'Present'

        }

        File DSLAppPackages
        {
            Type = 'Directory'
            DestinationPath = $Node.DSLPath + '\Application_Management\Packages\Windows_8_SxS'
            Ensure = 'Present'

        }

        File DSLOSDBoot
        {
            Type = 'Directory'
            DestinationPath = $Node.DSLPath + '\Operating_Systems\Boot\MDT_x64'
            Ensure = 'Present'

        }

        File DSLOSDDriverPackages
        {
            Type = 'Directory'
            DestinationPath = $Node.DSLPath + '\Operating_Systems\Drivers\Packages'
            Ensure = 'Present'

        }

        File DSLOSDDriverSource
        {
            Type = 'Directory'
            DestinationPath = $Node.DSLPath + '\Operating_Systems\Drivers\Source'
            Ensure = 'Present'

        }

        File DSLOSDImagesCapture
        {
            Type = 'Directory'
            DestinationPath = $Node.DSLPath + '\Operating_Systems\Images\Capture'
            Ensure = 'Present'

        }

        File DSLOSDImagesDeployment
        {
            Type = 'Directory'
            DestinationPath = $Node.DSLPath + '\Operating_Systems\Images\Deployment'
            Ensure = 'Present'

        }

        File DSLOSDImagesReference
        {
            Type = 'Directory'
            DestinationPath = $Node.DSLPath + '\Operating_Systems\Images\Reference'
            Ensure = 'Present'

        }

        File DSLOSDMDT2013CS
        {
            Type = 'Directory'
            DestinationPath = $Node.DSLPath + '\Operating_Systems\Tools\MDT2013_CustomSettings'
            Ensure = 'Present'

        }

        File DSLOSDMDT2013EF
        {
            Type = 'Directory'
            DestinationPath = $Node.DSLPath + '\Operating_Systems\Tools\MDT2013_ExtraFiles'
            Ensure = 'Present'

        }

        File DSLOSDMDT2013PS
        {
            Type = 'Directory'
            DestinationPath = $Node.DSLPath + '\Operating_Systems\Tools\MDT2013_PreStart'
            Ensure = 'Present'

        }

        File DSLOSDMDT2013TK
        {
            Type = 'Directory'
            DestinationPath = $Node.DSLPath + '\Operating_Systems\Tools\MDT2013_ToolKit'
            Ensure = 'Present'

        }

        File DSLOSDMDT2013WP
        {
            Type = 'Directory'
            DestinationPath = $Node.DSLPath + '\Operating_Systems\Tools\MDT2013_Wallpaper'
            Ensure = 'Present'

        }

        File DSLOSDUSMT8
        {
            Type = 'Directory'
            DestinationPath = $Node.DSLPath + '\Operating_Systems\Tools\USMT-ADK8'
            Ensure = 'Present'

        }

        File DSLSUPPackagesSCEP
        {
            Type = 'Directory'
            DestinationPath = $Node.DSLPath + '\Software_Updates\Packages\Endpoint_Protection_Updates'
            Ensure = 'Present'

        }

         File DSLSUPPackages2013
        {
            Type = 'Directory'
            DestinationPath = $Node.DSLPath + '\Software_Updates\Packages\Updates_2013'
            Ensure = 'Present'

        }

         File DSLSUPPackages2014
        {
            Type = 'Directory'
            DestinationPath = $Node.DSLPath + '\Software_Updates\Packages\Updates_2014'
            Ensure = 'Present'

        }

        File DSLSUPSource
        {
            Type = 'Directory'
            DestinationPath = $Node.DSLPath + '\Software_Updates\Source'
            Ensure = 'Present'

        }
    }    
}
