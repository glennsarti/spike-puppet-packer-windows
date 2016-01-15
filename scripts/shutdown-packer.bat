netsh advfirewall firewall set rule name="WinRM-HTTP" new action=block
shutdown /s /t 10 /f /d p:4:1 /c "Packer Shutdown"