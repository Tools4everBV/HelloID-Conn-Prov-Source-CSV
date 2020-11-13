$config = ConvertFrom-Json $configuration;
$departments = Import-CSV -Path $config.departmentsPath

foreach($item in $departments)
{
    $department = @{
        ExternalId=$item.ID;
        DisplayName=$item.Name;
        Name=$item.Name;
        ManagerExternalId=$item.ManagerID;
    }

    Write-Output ($department | ConvertTo-Json -Depth 50)
}
