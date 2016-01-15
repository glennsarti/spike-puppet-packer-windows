@ECHO OFF

REM Turn on the WinRM firewall exception
REM This allows Packer to connect via WinRM and then initiate shutdown
netsh advfirewall firewall set rule name="WinRM-HTTP" new action=allow