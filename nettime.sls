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
      
'HKEY_LOCAL_MACHINE\Software\NetTime\AlwaysProvideTime':
  reg.present:
    - vname: AlwaysProvideTime
    - vdata: 0
    - vtype: REG_DWORD
    - reflection: True

'HKEY_LOCAL_MACHINE\Software\NetTime\AutomaticUpdateChecks':
  reg.present:
    - vname: AutomaticUpdateChecks
    - vdata: 0
    - vtype: REG_DWORD
    - reflection: True

'HKEY_LOCAL_MACHINE\Software\NetTime\DaysBetweenUpdateChecks':
  reg.present:
    - vname: DaysBetweenUpdatedChecks
    - vdata: 7
    - vtype: REG_DWORD
    - reflection: True

'HKEY_LOCAL_MACHINE\Software\NetTime\DemoteOnErrorCount':
  reg.present:
    - vname: DemoteOnErrorCount
    - vdata: 4
    - vtype: REG_DWORD
    - reflection: True

'HKEY_LOCAL_MACHINE\Software\NetTime\Hostname':
  reg.present:
    - vname: Hostname
    - vdata: pool.ntp.org
    - vtype: REG_SZ
    - reflection: True

'HKEY_LOCAL_MACHINE\Software\NetTime\LargeAdjustmentAction':
  reg.present:
    - vname: LargeAdjustmentAction
    - vdata: 0
    - vtype: REG_DWORD
    - reflection: True

'HKEY_LOCAL_MACHINE\Software\NetTime\LargeAdjustmentThreshold':
  reg.present:
    - vname: LargeAdjustmentThreshold
    - vdata: 2
    - vtype: REG_DWORD
    - reflection: True

'HKEY_LOCAL_MACHINE\Software\NetTime\LargeAdjustmentThresholdUnits':
  reg.present:
    - vname: LargeAdjustmentThresholdUnits
    - vdata: 2
    - vtype: REG_DWORD
    - reflection: True

'HKEY_LOCAL_MACHINE\Software\NetTime\LogLevel':
  reg.present:
    - vname: LogLevel
    - vdata: 1
    - vtype: REG_DWORD
    - reflection: True

'HKEY_LOCAL_MACHINE\Software\NetTime\LostSync':
  reg.present:
    - vname: LostSync
    - vdata: 24
    - vtype: REG_DWORD
    - reflection: True

'HKEY_LOCAL_MACHINE\Software\NetTime\LostSyncUnits':
  reg.present:
    - vname: LostSyncUnits
    - vdata: 3
    - vtype: REG_DWORD
    - reflection: True

'HKEY_LOCAL_MACHINE\Software\NetTime\Port':
  reg.present:
    - vname: Port
    - vdata: 7b
    - vtype: REG_DWORD
    - reflection: True

'HKEY_LOCAL_MACHINE\Software\NetTime\Protocol':
  reg.present:
    - vname: Protocol
    - vdata: 0
    - vtype: REG_DWORD
    - reflection: True

'HKEY_LOCAL_MACHINE\Software\NetTime\Retry':
  reg.present:
    - vname: Retry
    - vdata: 1
    - vtype: REG_DWORD
    - reflection: True

'HKEY_LOCAL_MACHINE\Software\NetTime\RetryUnits':
  reg.present:
    - vname: RetryUnits
    - vdata: 2
    - vtype: REG_DWORD
    - reflection: True

'HKEY_LOCAL_MACHINE\Software\NetTime\Server':
  reg.present:
    - vname: Server
    - vdata: 0
    - vtype: REG_DWORD
    - reflection: True

'HKEY_LOCAL_MACHINE\Software\NetTime\SyncFreq':
  reg.present:
    - vname: SyncFreq
    - vdata: 15
    - vtype: REG_DWORD
    - reflection: True

'HKEY_LOCAL_MACHINE\Software\NetTime\SyncFreqUnits':
  reg.present:
    - vname: SyncFreqUnits
    - vdata: 2
    - vtype: REG_DWORD
    - reflection: True

start_nettime_svc:
  cmd.run:
    - name: Start-Service "nettime"
    - shell: powershell
    - require:
      - cmd: install_nettime
