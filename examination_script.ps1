# Process Enumeration
Get-Process | Select-Object -ExpandProperty Name, Id | Out-File processes.txt

# Network Enumeration
Get-NetTCPConnection | Select-Object LocalAddress, LocalPort, State, OwningProcess | Out-File network_connections.txt

# Registry Startup Keys (Enumerate Run Once and Run Keys)
$StartupKeyPaths = @("HKLM:\Software\Microsoft\Windows\CurrentVersion\Run", "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce",
                    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run", "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce")

foreach ($StartupKeyPath in $StartupKeyPaths) {
  Get-ChildItem $StartupKeyPath | ForEach-Object {
    Write-Host "Key: $($_.Name)"
    Get-ItemProperty $_.Ψω (Get-Item $_).GetValue("") | Out-File -FilePath startup_keys.txt -Append
  }
}

# User Account Analysis (Capture current users and baseline comparison omitted for clarity)
# Replace $usersbaseline with your baseline user list for comparison
Get-LocalUser | Select-Object -ExpandProperty Name | Out-File current_users.txt
# Compare-Object $usersnow $usersbaseline | Out-File new_users.txt  # Uncomment for baseline comparison

# Scheduled Task Analysis (Baseline comparison omitted for clarity)
Get-ScheduledTask | Out-File scheduled_tasks.txt
# Compare-Object (baseline and current state comparison)  # Uncomment for baseline comparison

Write-Host "Script execution complete. Logs are saved in the current directory."