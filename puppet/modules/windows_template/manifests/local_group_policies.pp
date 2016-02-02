class windows_template::local_group_policies ()
{
    # Search Group Policies and find their registry information
    # http://gpsearch.azurewebsites.net/
    
    registry::value { 'DisableServerManagerAtLogon2012':
        key   => 'HKLM\Software\Policies\Microsoft\Windows\Server\ServerManager',
        value => 'DoNotOpenAtLogon',
        data  => 1,
        type  => 'dword'     
    }
    registry::value { 'DisableServerManagerAtLogon2008':
        key   => 'HKLM\Software\Policies\Microsoft\Windows\Server\InitialConfigurationTasks',
        value => 'DoNotOpenAtLogon',
        data  => 1,
        type  => 'dword'     
    }

    registry::value { 'DisableShutdownTracker1':
        key   => 'HKLM\Software\Policies\Microsoft\Windows NT\Reliability',
        value => 'ShutdownReasonOn',
        data  => 0,
        type  => 'dword'     
    }
    registry::value { 'DisableShutdownTracker2':
        key   => 'HKLM\Software\Policies\Microsoft\Windows NT\Reliability',
        value => 'ShutdownReasonUI',
        data  => 0,
        type  => 'dword'     
    }

    registry::value { 'DisableWER':
        key   => 'HKLM\Software\Policies\Microsoft\Windows Error Reporting',
        value => 'Disabled',
        data  => 1,
        type  => 'dword'     
    }

    registry::value { 'UserModeCrashDumpFolder':
        key   => 'HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps',
        value => 'DumpFolder',
        data  => 'C:\crash_dumps',
        type  => 'expand'     
    }
    registry::value { 'UserModeCrashDumpCount':
        key   => 'HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps',
        value => 'DumpCount',
        data  => 10,
        type  => 'dword'     
    }
    registry::value { 'UserModeCrashDumpType':
        key   => 'HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps',
        value => 'DumpType',
        data  => 2,
        type  => 'dword'     
    }

    # TODO Apply super-insecure password policy Security Template
    
    # TODO Apply High Performance Power Management

    registry::value { 'DisableSystemRestore':
        key   => 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore',
        value => 'DisableSR',
        data  => 1,
        type  => 'dword'     
    }
    
    # TODO Change the Desktop Settings to "Classic" and Enable Best Performance <-- Use Boxstarter?

    exec { 'DisableScreenSaver':
        provider => powershell,
        command  => '& REG ADD "HKCU\Software\Policies\Microsoft\Windows\Control Panel\Desktop" /v ScreenSaveActive /t REG_SZ /d 0',
        unless   => '$val = $null; try { $val = ((Get-ItemProperty "Registry::HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Control Panel\Desktop").ScreenSaveActive) } catch { $val = $null }; if ( ($val -eq 0) -and ($val -ne $null) ) { exit 0 } else { exit 1 }'    
    }
    
    # TODO Up to Update Start Menu
}