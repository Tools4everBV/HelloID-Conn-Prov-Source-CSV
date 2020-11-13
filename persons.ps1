$config = ConvertFrom-Json $configuration;

$persons = Import-CSV -Path $config.personsPath 
$contracts = Import-CSV -Path $config.contractsPath

foreach($p in $persons)
{
    $person = @{};
    $person["ExternalId"] = $p.ID;
    $person["DisplayName"] = "$($p.FirstName) $($p.LastName) - $($p.ID)"
       
    $person["Contracts"] = [System.Collections.ArrayList]@();
    
    foreach($prop in $p.PSObject.properties)
    {
        $person[$prop.Name] = "$($prop.Value)"
    }

    foreach($item in $contracts)
    {
        if($item.PersonID -eq $p.ID)
        {
            $contract = @{}; 
            $contract["ExternalID"] = $item.ID;
            
            foreach($prop in $item.PSObject.properties)  
            {
                $contract[$prop.Name] = "$($prop.Value)"
            }
            [void]$person.Contracts.Add($contract);
        }
    }

    
    Write-Output ($person | ConvertTo-Json -Depth 50)
}
