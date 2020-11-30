# terraform-data_source_linux_performance_object
This module creates a Data Source Linux Performance Object using local-exec provisioner.

# EXAMPLE

```sh
module "data_source_linux_custom_log" {
  source = " BartoszDopke/terraform-data_source_linux_performance_object "

  resource_group_name   = module.resource_group.name
  workspace_name        = module.workspace.name
  custom_file_name      = "/var/log/your_name/your_name.log"
  custom_log_name       = "your_name"
} 
```
