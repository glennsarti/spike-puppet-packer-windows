
# local_gpo.ps1 - newline is REQUIRED above
$PolicyType = '<%= @policy_type %>'  # Machine or User
$PolicyKeyName = '<%= @key %>'
$PolicyValueName = '<%= @valuename %>'
$PolicyValue = '<%= @data %>'
$PolicyValueType = '<%= @type %>'

#Write-Host "PolicyType = $PolicyType"
#Write-Host "PolicyKeyName = $PolicyType"
#Write-Host "PolicyValueName = $PolicyValueName"
#Write-Host "PolicyValue = $PolicyValue"
#Write-Host "PolicyValueType = $PolicyValueType"

$vp = $VerbosePreference
$VerbosePreference = 'SilentlyContinue'
# To import on PowerShell v3, you can use this command: 
Add-Type -Language CSharp -TypeDefinition $PolFileEditorCS -ErrorAction Stop
# To make it work on PowerShell v2, use this command instead: 
# Add-Type -Language CSharpVersion3 -TypeDefinition $PolFileEditorCS -ErrorAction Stop
$VerbosePreference = $vp 

function Compare-PolicyValueIsSameAs($objPolicyEntry,$value)
{
  $isSame = $false
  switch ($objPolicyEntry.Type)
  {
    'REG_SZ' { $isSame = ($objPolicyEntry.StringValue -eq $value)}
    'REG_DWORD' { $isSame = ($objPolicyEntry.DWORDValue -eq [int]$value)}
    Default { throw "Unknown PolEntryType $($objPolicyEntry.Type)"}
  }
  Write-Output $isSame
}

function Set-PolicySetting($objPolicy)
{
  # Set the policy setting
  switch ($PolicyValueType.ToUpper()) {
    "REG_DWORD" {
      $objPolicy.SetDWORDValue($PolicyKeyName,$PolicyValueName,[int]$PolicyValue) | Out-Null
    }
    "REG_SZ" {
      $objPolicy.SetStringValue($PolicyKeyName,$PolicyValueName,$PolicyValue) | Out-Null
    }
    Default {
      throw "Unknown PolEntryType $($PolicyValueType.Type)"
      return $false
    }
  }

  # Save the policy file
  $objPolicy.SaveFile() | Out-Null

  # Increment the gpt.ini version number
  $gptContents = Get-Content $env:systemroot\system32\GroupPolicy\gpt.ini
  $gptContents |
  ForEach-Object {
    if ($_ -match "Version=(\d+)$") {
      Write-Output "Version=$( ([int]$matches[1]) + 1 )"
    } else { Write-Output $_ }
  } | Set-Content $env:systemroot\system32\GroupPolicy\gpt.ini | Out-Null
  return $true
}

function Open-PolicyFile()
{
  # TODO - Create a blank file if non exists
  $objPolicy = $null
  # Open the policy file
  try 
  { 
    $objPolicy = New-Object TJX.PolFileEditor.PolFile 
    $objPolicy.LoadFile("$($env:systemroot)\system32\GroupPolicy\$PolicyType\registry.pol")     
  } 
  catch 
  { 
    $objPolicy = $null
  }
  Write-Output $objPolicy
}
 