# Get Module
Import-Module GroupPolicy

# Export GPO's to one HTML report:

Get-GPOReport -All -ReportType HTML -Path C:\GPOReports\gpos-report.HTML

<#
Export each GPO to it's own HMTL file
%{ $_.displayname } ⇔ ForEach-Object { Write-Output $_.displayname }
#>
Get-GPO -All | %{
    Get-GPOReport -name $_.displayname -ReportType html -path ("c:\GPOReports\"+$_.displayname+".html")
}

# Let’s find GPO’s with all settings disabled:

$reportFile = "c:\GPOReports\AllSettingsDisabledGpos.csv"
Set-Content -Path $reportFile -Value ("GPO Name,Settings")
Get-GPO -All | where{ $_.GpoStatus -eq "AllSettingsDisabled" } | % {
    add-Content -Path $reportFile -Value ($_.displayName+","+$_.gpoStatus)
}

# Now let’s find Gpo’s that don’t apply to no one, and those that apply find out to who’m:

$reportFile = "c:\GPOReports\GPOApplyToPermissions.csv"
Set-Content -Path $reportFile -Value ("GPO Name,User/Group,Denied")
Get-GPO -All | %{
    $gpoName = $_.displayName
    [int]$counter = 0
    $security = $_.GetSecurityInfo()
    $security | where{ $_.Permission -eq "GpoApply" } | %{
        add-Content -Path $reportFile -Value ($gpoName + "," + $_.trustee.name+","+$_.denied)
        $counter += 1
    }
    if ($counter -eq 0)
    {
        add-Content -Path $reportFile -Value ($gpoName + ",NOT APPLIED")
    }
}

# Run this to check the resolves in powershell CLI
Import-Csv -Path .\GPOApplyToPermissions.csv | ft




# Get GPO’s, their links and WMI filters:

$reportFile = "c:\GPOReports\GPOLinksAndWMIFilters.csv"
Set-Content -Path $reportFile -Value ("GPO Name,# Links,Link Path,Enabled,No Override,WMI Filter")
$gpmc = New-Object -ComObject GPMgmt.GPM
$constants = $gpmc.GetConstants()
Get-GPO -All | %{
    [int]$counter = 0
    [xml]$report = $_.GenerateReport($constants.ReportXML)
    try
    {
        $wmiFilterName = $report.gpo.filtername
    }
    catch
    {
        $wmiFilterName = "none"
    }
    $report.GPO.LinksTo | % {
        if ($_.SOMPath -ne $null)
        {
            $counter += 1
            add-Content -Path $reportFile -Value ($report.GPO.Name + "," + $report.GPO.linksto.Count + "," + $_.SOMPath + "," + $_.Enabled + "," + $_.NoOverride + "," + $wmiFilterName)
        }
    }
    if ($counter -eq 0)
    {
        add-Content -Path $reportFile -Value ($report.GPO.Name + "," + $counter + "," + "NO LINKS" + "," + "NO LINKS" + "," + "NO LINKS")
    }
}

<#
And let’s find the Organizational Units with Block GPO Inheritance:
We will need to load Active Directory module for this one also.
#>

# find AD Organicational Units to use
Get-ADOrganizationalUnit -Filter 'Name -like "*"' | Format-Table Name, DistinguishedName -A


# Run this cript to find OU with Block Inharitance
Import-Module ActiveDirectory
$reportFile = "c:\GPOReports\OUsWithBlockInharit.csv"
set-Content -Path $reportFile -Value ("Block Inharitance OU Path")
Get-ADOrganizationalUnit -SearchBase "DC=Your,DC=Domain" -Filter * | Get-GPInheritance | Where-Object { $_.GPOInheritanceBlocked } | %{
    add-Content -Path $reportFile -Value ($_.path)
}