#Salt state to stop and disable MS W32Time Sync as well as install and configure nettime ntp client
#Written by Rich Staats last updated Aug 26 2015

Disable_W32Time:
  cmd.run:
    - name: "Set-Service w32time -StartupType disabled"
    - shell: powershell

Stop_W32Time:
  cmd.run:
    - name: "Stop-Service w32time"
    - shell: powershell

C:\\nettime.exe:
  file.managed:
    - source: salt://files/win/nettime.exe

install_nettime:
  cmd.run:
    - name: "C:\\nettime.exe /verysilent"
    - require:
      - file: C:\\nettime.exe

'HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\Subjective Software\\NetTime\\AlwaysProvideTime':
  reg.present:
    - value: 0
    - vtype: REG_DWORD

'HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\Subjective Software\\NetTime\\AutomaticUpdateChecks':
  reg.present:
    - value: 0
    - vtype: REG_DWORD

'HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\Subjective Software\\NetTime\\DaysBetweenUpdateChecks':
  reg.present:
    - value: 7
    - vtype: REG_DWORD

'HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\Subjective Software\\NetTime\\DemoteOnErrorCount':
  reg.present:
    - value: 4
    - vtype: REG_DWORD

'HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\Subjective Software\\NetTime\\Hostname':
  reg.present:
    - value: pool.ntp.org
    - vtype: REG_SZ

'HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\Subjective Software\\NetTime\\LargeAdjustmentAction':
  reg.present:
    - value: 0
    - vtype: REG_DWORD

'HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\Subjective Software\\NetTime\\LargeAdjustmentThreshold':
  reg.present:
    - value: 2
    - vtype: REG_DWORD

'HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\Subjective Software\\NetTime\\LargeAdjustmentThresholdUnits':
  reg.present:
    - value: 2
    - vtype: REG_DWORD

'HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\Subjective Software\\NetTime\\LogLevel':
  reg.present:
    - value: 1
    - vtype: REG_DWORD

'HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\Subjective Software\\NetTime\\LostSync':
  reg.present:
    - value: 24
    - vtype: REG_DWORD

'HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\Subjective Software\\NetTime\\LostSyncUnits':
  reg.present:
    - value: 3
    - vtype: REG_DWORD

'HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\Subjective Software\\NetTime\\Port':
  reg.present:
    - value: 123
    - vtype: REG_DWORD

'HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\Subjective Software\\NetTime\\Protocol':
  reg.present:
    - value: 0
    - vtype: REG_DWORD

'HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\Subjective Software\\NetTime\\Retry':
  reg.present:
    - value: 1
    - vtype: REG_DWORD

'HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\Subjective Software\\NetTime\\RetryUnits':
  reg.present:
    - value: 2
    - vtype: REG_DWORD

'HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\Subjective Software\\NetTime\\Server':
  reg.present:
    - value: 0
    - vtype: REG_DWORD

'HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\Subjective Software\\NetTime\\SyncFreq':
  reg.present:
    - value: 15
    - vtype: REG_DWORD

'HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\Subjective Software\\NetTime\\SyncFreqUnits':
  reg.present:
    - value: 2
    - vtype: REG_DWORD
    
add_missing_reg:
  cmd.run:
    - name: New-ItemProperty 'HKLM:\SOFTWARE\Wow6432Node\Subjective Software\NetTime' -Name "Protocol" -Value 0 -PropertyType "DWord"
    - shell: powershell
    - require:
        - cmd: install_nettime

restart_nettime_svc:
  cmd.run:
    - name: Restart-Service "nettime"
    - shell: powershell
    - require:
      - cmd: install_nettime
