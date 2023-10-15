function Show-Menu {
    Clear-Host
    Write-Host "Select an option:"
    Write-Host "1. Backup"
    Write-Host "2. Cleanup"
    Write-Host "3. File Synchronization"
    Write-Host "4. Software Updates"
    Write-Host "5. Scheduled Shutdown"
    Write-Host "6. Network Diagnostics"
    Write-Host "7. System Monitoring"
    Write-Host "8. System Information"
    Write-Host "9. Event Log Viewer"
    Write-Host "10. Remote Desktop Control"
    Write-Host "11. Performance Optimization"
    Write-Host "12. Network Speed Test"
    Write-Host "13. Quit"
    $choice = Read-Host "Enter the option number"

    switch ($choice) {
        "1" { Backup }
        "2" { Cleanup }
        "3" { Synchronize }
        "4" { SoftwareUpdates }
        "5" { ScheduledShutdown }
        "6" { NetworkDiagnostics }
        "7" { SystemMonitoring }
        "8" { SystemInformation }
        "9" { EventLog }
        "10" { RemoteControl }
        "11" { PerformanceOptimization }
        "12" { NetworkSpeedTest }
        "13" { exit }
        Default { Show-Menu }
    }
}

function Backup {
    $source = Read-Host "Enter the source file or directory"
    $destination = Read-Host "Enter the destination directory"

    Write-Host "Copying $source to $destination..."
    Copy-Item -Path $source -Destination $destination -Recurse
    Read-Host "Press Enter to continue..."
    Show-Menu
}

function Cleanup {
    Write-Host "Cleaning up..."
    Remove-Item -Path "C:\Temp\*" -Force

    Write-Host "Cleaning up DNS cache..."
    ipconfig /flushdns

    Write-Host "Cleaning up Internet Explorer cache..."
    RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8

    Write-Host "Cleaning up Microsoft Edge cache..."
    Write-Host "y | cd $env:localappdata\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\#!001\MicrosoftEdge\Cache"
    Write-Host "del * | cd User\Default | del * | cd"
    Read-Host "Press Enter to continue..."
    Show-Menu
}

function Synchronize {
    $source = Read-Host "Enter the source directory"
    $destination = Read-Host "Enter the destination directory"

    Write-Host "Synchronizing files from $source to $destination..."
    robocopy "$source" "$destination" /MIR
    Read-Host "Press Enter to continue..."
    Show-Menu
}

function SoftwareUpdates {
    Write-Host "Checking for software updates..."
    # Check for updates using Windows Update
    wuauclt /detectnow
    Read-Host "Press Enter to continue..."
    Show-Menu
}

function ScheduledShutdown {
    Write-Host "Select a shutdown option:"
    Write-Host "1. Shutdown in 30 minutes"
    Write-Host "2. Shutdown in 60 minutes"
    Write-Host "3. Shutdown in 2 hours"
    Write-Host "4. Shutdown in 6 hours"
    Write-Host "5. Shutdown in 12 hours"
    $shutdownchoice = Read-Host "Enter the option number"

    switch ($shutdownchoice) {
        "1" { ScheduleShutdown 30 }
        "2" { ScheduleShutdown 60 }
        "3" { ScheduleShutdown 120 }
        "4" { ScheduleShutdown 360 }
        "5" { ScheduleShutdown 720 }
        Default { Show-Menu }
    }
}

function ScheduleShutdown {
    param (
        [int] $minutes
    )

    Write-Host "Scheduling a shutdown in $minutes minutes..."
    # Schedule a system shutdown in the specified minutes
    shutdown /s /f /t ($minutes * 60)
    Read-Host "Press Enter to continue..."
    Show-Menu
}

function NetworkDiagnostics {
    Write-Host "Running network diagnostics..."

    # Display IP configuration
    ipconfig /all

    # Check connectivity by pinging Google
    ping google.com

    # Display routing table
    route print

    # Show active network connections
    netstat -ano

    # Display ARP table
    arp -a

    Read-Host "Press Enter to continue..."
    Show-Menu
}

function SystemMonitoring {
    Write-Host "Monitoring system resources..."

    # List running processes
    Get-Process | Format-Table -AutoSize

    Read-Host "Press Enter to continue..."
    Show-Menu
}

function SystemInformation {
    Write-Host "Gathering system information..."

    # Display system information
    systeminfo

    Read-Host "Press Enter to continue..."
    Show-Menu
}

function EventLog {
    Write-Host "Viewing Windows Event Log..."

    # View Application Event Log
    eventvwr

    Read-Host "Press Enter to continue..."
    Show-Menu
}

function RemoteControl {
    Write-Host "Launching Remote Desktop Connection..."

    # Start Remote Desktop Connection
    mstsc

    Read-Host "Press Enter to continue..."
    Show-Menu
}

function PerformanceOptimization {
    Write-Host "Optimizing system performance..."

    # Defragment the C: drive
    defrag C: /O

    # Adjust power settings for better performance
    powercfg /setactive scheme_min

    Read-Host "Press Enter to continue..."
    Show-Menu
}

function NetworkSpeedTest {
    Write-Host "Running network speed test..."

    $targetHost = "www.google.com"  # You can change the target host if needed
    $result = Test-Connection -ComputerName $targetHost -Count 10

    Write-Host "Network Speed Test Results:"
    Write-Host "Average Response Time (ms): $($($result.ResponseTime | Measure-Object -Average).Average)"
    
    $totalPacketsSent = $result.PSComputerName.Count
    $totalPacketsReceived = ($result | Where-Object ResponseTime -ne $null).PSComputerName.Count
    $packetLossPercentage = (($totalPacketsSent - $totalPacketsReceived) / $totalPacketsSent) * 100

    Write-Host "Packet Loss (%): $packetLossPercentage"

    Read-Host "Press Enter to continue..."
    Show-Menu
}

Show-Menu
