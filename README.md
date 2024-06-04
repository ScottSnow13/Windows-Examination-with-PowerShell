# Windows Examination with PowerShell

This repo walkthrough outlines how to use PowerShell commands to examine a Windows system for signs of potential compromise.

## Requirements:

**`Windows 10 VM`** 

**`Administrator privileges on the VM`**

## Preparation:

Open an Administrator PowerShell session (right-click on the PowerShell icon and select "Run as administrator").

## Process Enumeration:

1. Identify running processes using **`Get-Process`**.

2. View specific process details by adding the process name after **`Get-Process`** (e.g., **`Get-Process lsass`**).

3. Filter process information using **`Select-Object -Property Name, Id`** to see only the process name and ID.

4. Use **`Where-Object`** to filter processes based on specific criteria (e.g., **`Get-Process | Where-Object -Property Path -Like "*temp*"`** to find processes running from temporary directories).

## Network Enumeration:

1. List network connections using **`Get-NetTCPConnection`**.

2. Focus on relevant details like Local Address, Local Port, State, and OwningProcess using **`Select-Object -Property LocalAddress, LocalPort, State, OwningProcess`**.

3. Investigate suspicious processes by correlating their IDs with **`Get-Process`**.

## Registry Startup Keys:

1. Identify common registry keys used for automatic startup:

  - **`HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run`**
  
  - **`HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce`**
  
  - **`HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run`**
  
  - **`HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce`**

2. Use **`Get-ChildItem`** to enumerate registry keys and **`Get-ItemProperty`** to view their values.

3. Remove suspicious startup entries using **`Remove-ItemProperty`**.

## Differential Analysis:

1. Establish a baseline for services, scheduled tasks, and local users by capturing their information at a known good state and saving them to files. (These baseline files might be provided in your specific VM).

2. Compare the current system state with the baseline using the same commands (e.g., **`Get-Service`**) and saving the output to new files.

3. Use **`Compare-Object`** to identify discrepancies between the baseline and current state.

## User Account Analysis:

1. Capture the current list of local users with **`Get-LocalUser | Select-Object -ExpandProperty Name | Out-File localusers.txt`**.

2. Compare the current user list (**`$usersnow`**) with the baseline (**`$usersbaseline`**) using **`Compare-Object`**.

3. The output will show any new user accounts created since the baseline was established.

## Scheduled Task Analysis:

1. List scheduled tasks with **`Get-ScheduledTask`**.

2. Compare the current list of tasks with a baseline using **`Compare-Object`**.

3. The output will reveal any newly added scheduled tasks.

### Remember: 

This is a foundational walkthrough. Further investigation is needed to determine if identified anomalies are truly malicious.

### Note:

The specific commands and steps might vary depending on the VM you are using.

