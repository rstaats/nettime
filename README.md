# nettime

Download nettime from timesynctool.com, place in your /srv/salt/files/windows directory and rename the exe to nettime.exe. nettime.sls is written for the newer version of salt which utilized the reflection statements and used different style for writing to the registery. Line 55 of this statement is where you can change the ntp server to something other than what I placed in there (pool.ntp.org)

Nettimelegacy.sls works with older versions of salt (tested with 2014.x) and contains a powershell statement to add the missing registry key (in the older verison if a key doesn't exist yet it is ignored, hence the need for this statement. Line 46 of this state is where you can change the NTP server specified. 
