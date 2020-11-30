resource null_resource linux-performance-object {
  # triggers = {
  #   always = "${uuid()}"         #uncomment if you want resource re-deployment (mandatory when changes in PS script)
  # }
  provisioner "local-exec" {
    when    = create
    command = <<EOT

  Get-AzContext

# =============================== DO NOT EDIT ================================
# Counters
$NetworkCounters = @(
    "Total Bytes Transmitted",
    "Total Bytes Received"
)
$LogicalDiskCounters = @(
    "% Used Inodes",
    "Free Megabytes",
    "% Free Space",
    "% Used Space",
    "Disk Transfers/sec",
    "Disk Reads/sec",
    "Disk Writes/sec"
)
$ProcessorCounters = @(
    "% Processor Time"
)
$MemoryCounters = @(
    "Available MBytes Memory",
    "% Used Memory",
    "% Used Swap Space"
)
$SystemCounters = @(
    "Uptime",
    "Users"
)
$ProcessCounters = @(
    "Pct Privileged Time",
    "Pct User Time"
)


# New definitions
if(Get-AzOperationalInsightsDataSource -ResourceGroupName "${var.resource_group_name}" -WorkspaceName "${var.workspace_name}" -Name "Network Linux Disk Performance Counters") { 
  Write-Host "Network Linux Disk Performance Counters exist" 
  } 
  else {  
  New-AzOperationalInsightsLinuxPerformanceObjectDataSource   -ResourceGroupName ${var.resource_group_name} -WorkspaceName ${var.workspace_name} `
                                                              -ObjectName "Network" `
                                                              -InstanceName "*"  `
                                                              -CounterNames $NetworkCounters `
                                                              -IntervalSeconds 60  `
                                                              -Name "Network Linux Disk Performance Counters"
                                                                }

if(Get-AzOperationalInsightsDataSource -ResourceGroupName "${var.resource_group_name}" -WorkspaceName "${var.workspace_name}" -Name "LogicalDisk Linux Disk Performance Counters") { 
  Write-Host "LogicalDisk Linux Disk Performance Counters exist" 
  } 
  else {
New-AzOperationalInsightsLinuxPerformanceObjectDataSource   -ResourceGroupName ${var.resource_group_name} -WorkspaceName ${var.workspace_name} `
                                                            -ObjectName "Logical Disk" `
                                                            -InstanceName "*"  `
                                                            -CounterNames $LogicalDiskCounters `
                                                            -IntervalSeconds 60  `
                                                            -Name "LogicalDisk Linux Disk Performance Counters"
                                                            }
                                                            
if(Get-AzOperationalInsightsDataSource -ResourceGroupName "${var.resource_group_name}" -WorkspaceName "${var.workspace_name}" -Name "Processor Linux Disk Performance Counters") { 
  Write-Host "Processor Linux Disk Performance Counters exist" 
  } 
  else {                                                           
New-AzOperationalInsightsLinuxPerformanceObjectDataSource   -ResourceGroupName ${var.resource_group_name} -WorkspaceName ${var.workspace_name} `
                                                            -ObjectName "Processor" `
                                                            -InstanceName "*"  `
                                                            -CounterNames $ProcessorCounters `
                                                            -IntervalSeconds 60  `
                                                            -Name "Processor Linux Disk Performance Counters" 
                                                            }

if(Get-AzOperationalInsightsDataSource -ResourceGroupName "${var.resource_group_name}" -WorkspaceName "${var.workspace_name}" -Name "Memory Linux Disk Performance Counters") { 
  Write-Host "Memory Linux Disk Performance Counters exist" 
  } 
  else {                                                             
New-AzOperationalInsightsLinuxPerformanceObjectDataSource   -ResourceGroupName ${var.resource_group_name} -WorkspaceName ${var.workspace_name} `
                                                            -ObjectName "Memory" `
                                                            -InstanceName "*"  `
                                                            -CounterNames $MemoryCounters `
                                                            -IntervalSeconds 60  `
                                                            -Name "Memory Linux Disk Performance Counters"
                                                            }

if(Get-AzOperationalInsightsDataSource -ResourceGroupName "${var.resource_group_name}" -WorkspaceName "${var.workspace_name}" -Name "System Linux Disk Performance Counters") { 
  Write-Host "System Linux Disk Performance Counters exist" 
  } 
  else {                                                            
New-AzOperationalInsightsLinuxPerformanceObjectDataSource   -ResourceGroupName ${var.resource_group_name} -WorkspaceName ${var.workspace_name} `
                                                            -ObjectName "System" `
                                                            -InstanceName "*"  `
                                                            -CounterNames $SystemCounters `
                                                            -IntervalSeconds 60  `
                                                            -Name "System Linux Disk Performance Counters"
                                                            }

if(Get-AzOperationalInsightsDataSource -ResourceGroupName "${var.resource_group_name}" -WorkspaceName "${var.workspace_name}" -Name "Process Linux Disk Performance Counters") { 
  Write-Host "Process Linux Disk Performance Counters exist" 
  } 
  else {                                                            
New-AzOperationalInsightsLinuxPerformanceObjectDataSource   -ResourceGroupName ${var.resource_group_name} -WorkspaceName ${var.workspace_name} `
                                                            -ObjectName "Process" `
                                                            -InstanceName "*"  `
                                                            -CounterNames $ProcessCounters `
                                                            -IntervalSeconds 60  `
                                                            -Name "Process Linux Disk Performance Counters"   
                                                            }                                                       

# Enabling definitions
Enable-AzOperationalInsightsLinuxPerformanceCollection -ResourceGroupName ${var.resource_group_name} -WorkspaceName ${var.workspace_name}
      EOT

    interpreter = ["pwsh", "-Command"]
  }
}