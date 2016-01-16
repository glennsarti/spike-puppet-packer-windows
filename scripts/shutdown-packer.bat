REM shutdown /s /t 60 /f /d p:4:1 /c "Packer Shutdown"

powershell "& { Start-Sleep -Seconds 5; Stop-Service Winrm -ErrorAction SilentlyContinue; (& netsh advfirewall firewall set rule name=WinRM-HTTP new action=block) }"

REM netsh advfirewall firewall set rule name="WinRM-HTTP" new action=block

EXIT /B 0