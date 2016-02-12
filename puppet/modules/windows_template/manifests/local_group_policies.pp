class windows_template::local_group_policies ()
{
    # Search Group Policies and find their registry information
    # http://gpsearch.azurewebsites.net/

    windows_group_policy::gpupdate { 'GPUpdate':
    }
    
    windows_group_policy::local::machine { 'DisableServerManagerAtLogon2012':
        key   => 'Software\Policies\Microsoft\Windows\Server\ServerManager',
        value => 'DoNotOpenAtLogon',
        data  => 1,
        type  => 'REG_DWORD',
        notify => Windows_group_policy::Gpupdate['GPUpdate'],
    }
    windows_group_policy::local::machine { 'DisableServerManagerAtLogon2008':
        key   => 'Software\Policies\Microsoft\Windows\Server\InitialConfigurationTasks',
        value => 'DoNotOpenAtLogon',
        data  => 1,
        type  => 'REG_DWORD',
        notify => Windows_group_policy::Gpupdate['GPUpdate'],
    }

    windows_group_policy::local::machine { 'DisableShutdownTracker1':
        key   => 'Software\Policies\Microsoft\Windows NT\Reliability',
        value => 'ShutdownReasonOn',
        data  => 0,
        type  => 'REG_DWORD',
        notify => Windows_group_policy::Gpupdate['GPUpdate'],
    }
    windows_group_policy::local::machine { 'DisableShutdownTracker2':
        key   => 'Software\Policies\Microsoft\Windows NT\Reliability',
        value => 'ShutdownReasonUI',
        data  => 0,
        type  => 'REG_DWORD',
        notify => Windows_group_policy::Gpupdate['GPUpdate'],
    }

    windows_group_policy::local::machine { 'DisableWER':
        key   => 'Software\Policies\Microsoft\Windows Error Reporting',
        value => 'Disabled',
        data  => 1,
        type  => 'REG_DWORD',
        notify => Windows_group_policy::Gpupdate['GPUpdate'],
    }

    # Windows Error Reporting
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

    windows_group_policy::local::machine { 'DisableSystemRestore':
        key   => 'SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore',
        value => 'DisableSR',
        data  => 1,
        type  => 'REG_DWORD',
        notify => Windows_group_policy::Gpupdate['GPUpdate'],
    }
    
    # TODO Change the Desktop Settings to "Classic" and Enable Best Performance <-- Use Boxstarter?

    exec { 'DisableScreenSaver':
        provider => powershell,
        command  => '& REG ADD "HKCU\Software\Policies\Microsoft\Windows\Control Panel\Desktop" /v ScreenSaveActive /t REG_SZ /d 0',
        unless   => '$val = $null; try { $val = ((Get-ItemProperty "Registry::HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Control Panel\Desktop").ScreenSaveActive) } catch { $val = $null }; if ( ($val -eq 0) -and ($val -ne $null) ) { exit 0 } else { exit 1 }'    
    }
    
    # TODO Update Start Menu 2008 only
    
    # TODO Modify Notification Icon Tray
    
    windows_group_policy::local::machine { 'DisableHibernationOnBattery':
        key   => 'Software\Policies\Microsoft\Power\PowerSettings\94ac6d29-73ce-41a6-809f-6363ba21b47e',
        value => 'DCSettingIndex',
        data  => 0,
        type  => 'REG_DWORD',
        notify => Windows_group_policy::Gpupdate['GPUpdate'],
    }
    windows_group_policy::local::machine { 'DisableHibernationPluggedIn':
        key   => 'Software\Policies\Microsoft\Power\PowerSettings\94ac6d29-73ce-41a6-809f-6363ba21b47e',
        value => 'ACSettingIndex',
        data  => 0,
        type  => 'REG_DWORD',
        notify => Windows_group_policy::Gpupdate['GPUpdate'],
    }
    
}