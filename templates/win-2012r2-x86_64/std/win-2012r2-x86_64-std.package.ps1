$ErrorActionPreference = "Stop"

# Boxstarter options
$Boxstarter.RebootOk=$true # Allow reboots?
$Boxstarter.NoPassword=$false # Is this a machine with no login password?
$Boxstarter.AutoLogin=$true # Save my password securely and auto-login after a reboot

if (Test-PendingReboot){ Invoke-Reboot }

Write-BoxstarterMessage "Disabling Hiberation..."
Set-ItemProperty -Path 'Registry::HKLM\SYSTEM\CurrentControlSet\Control\Power' -Name 'HibernateFileSizePercent' -Value 0
Set-ItemProperty -Path 'Registry::HKLM\SYSTEM\CurrentControlSet\Control\Power' -Name 'HibernateEnabled' -Value 0

Write-BoxstarterMessage "Installing Puppet Agent..."
# https://downloads.puppetlabs.com/windows/puppet-agent-x64-latest.msi
#choco install puppet-agent -installArgs '"PUPPET_AGENT_STARTUP_MODE=manual"' -y

Write-BoxstarterMessage "Extracting Puppet archive..."
# %ChocolateyInstall%\Tools\7za.exe A:\PUPPET.ZIP to where?

# TODO Download modules from the forge

# TODO Loop Puppet Apply until no resources are changed.  With Invoke-Reboot inbetween

# TODO Uninstall Puppet Agent using choco

# TODO Cleanup puppet log files etc.

Write-Host Staring CMD.exe
& cmd.exe /c Start cmd.exe
Read-Host "Press enter"

#if (Test-PendingReboot) { Invoke-Reboot }

# Remove the pagefile
Write-BoxstarterMessage "Removing page file.  Recreates on next boot"
$pageFileMemoryKey = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
Set-ItemProperty -Path $pageFileMemoryKey -Name PagingFiles -Value ""

$enableArgs=@{Force=$true}
try {
 $command=Get-Command Enable-PSRemoting
  if($command.Parameters.Keys -contains "skipnetworkprofilecheck"){
      $enableArgs.skipnetworkprofilecheck=$true
  }
}
catch {
  $global:error.RemoveAt(0)
}
Enable-PSRemoting @enableArgs
Enable-WSManCredSSP -Force -Role Server
# NOTE - This is insecure but can be shored up in later customisation.  Required for Vagrant and other provisioning tools
winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
Write-BoxstarterMessage "WinRM setup complete"
