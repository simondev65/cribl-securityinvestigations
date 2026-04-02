#resource "criblio_pack" "search_pack" {
#    id              = "securityinvestigation"
 #   group_id        = "default_search"
#  display_name    = "cribl security investigation search pack"
#    filename        = "cribl_search_securityinvestigation_0.0.1.crbl"
#    version         = "0.0.1"
#    description     = "Cribl Search pack for security investigation"
# depends_on = [criblio_search_dataset_provider.securityinvestigation_provider]
#}

# Create the search dataset provider
resource "criblio_search_dataset_provider" "securityinvestigation_provider" {
  s3_provider = {
    id                        = "securityinvestigation_provider"
    type                      = "s3"
    description               = "s3 provider for security investigation"
    aws_authentication_method = "auto"
    aws_secret_key            = ""
    enable_assume_role        = true
    assume_role_arn           = var.assume_role_arn
    assume_role_external_id   = var.assume_role_external_id
    signature_version         = "v4"
  }
}

# S3 dataset for Windows Security event log search 
resource "criblio_search_dataset" "securityinvestigation_windows_security" {
  s3_dataset = {
    id                     = "securityinvestigation_windows_security"
    type                   = "s3"
    provider_id            = "securityinvestigation_provider"
    filter                 = "dataSource.startsWith('WinEventLog:Security') && ['2016','2017','2018'].indexOf(version)>=0"
    description            = "S3 dataset for Windows Security event logs"
    region                 = var.aws_region
    skip_event_time_filter = true
    bucket                 = "${var.s3_investigation_bucket}/$${version}/$${dataSource}/$${origin_source}/$${host}/$${_time:%Y}/$${_time:%m}/$${_time:%d}/"
    storage_classes        = ["STANDARD"]

  }

  depends_on = [criblio_search_dataset_provider.securityinvestigation_provider]
}
# S3 dataset for Windows application event log search 
resource "criblio_search_dataset" "securityinvestigation_windows_application" {
  s3_dataset = {
    id                     = "securityinvestigation_windows_application"
    type                   = "s3"
    provider_id            = "securityinvestigation_provider"
    filter                 = "dataSource.startsWith('WinEventLog:Application') && ['2016','2017','2018'].indexOf(version)>=0"
    description            = "S3 dataset for Windows application event logs"
    region                 = var.aws_region
    skip_event_time_filter = true
    bucket                 = "${var.s3_investigation_bucket}/$${version}/$${dataSource}/$${origin_source}/$${host}/$${_time:%Y}/$${_time:%m}/$${_time:%d}/"
    storage_classes        = ["STANDARD"]

  }

  depends_on = [criblio_search_dataset_provider.securityinvestigation_provider]
}
# S3 dataset for Windows sysmon event log search 
resource "criblio_search_dataset" "securityinvestigation_windows_sysmon" {
  s3_dataset = {
    id                     = "securityinvestigation_windows_sysmon"
    type                   = "s3"
    provider_id            = "securityinvestigation_provider"
    filter                 = "dataSource.startsWith('XmlWinEventLog:Microsoft-Windows-Sysmon-Operational') && ['2016','2017','2018'].indexOf(version)>=0"
    description            = "S3 dataset for Windows sysmon event logs "
    region                 = var.aws_region
    skip_event_time_filter = true
    bucket                 = "${var.s3_investigation_bucket}/$${version}/$${dataSource}/$${origin_source}/$${host}/$${_time:%Y}/$${_time:%m}/$${_time:%d}/"
    storage_classes        = ["STANDARD"]

  }

  depends_on = [criblio_search_dataset_provider.securityinvestigation_provider]
}

# S3 dataset for Windows Security event log search 
resource "criblio_search_dataset" "securityinvestigation_2016_windows_system" {
  s3_dataset = {
    id                     = "securityinvestigation_windows_system"
    type                   = "s3"
    provider_id            = "securityinvestigation_provider"
    filter                 = "dataSource.startsWith('WinEventLog:System') && ['2016','2017','2018'].indexOf(version)>=0"
    description            = "S3 dataset for Windows system event logs"
    region                 = var.aws_region
    skip_event_time_filter = true
    bucket                 = "${var.s3_investigation_bucket}/$${version}/$${dataSource}/$${origin_source}/$${host}/$${_time:%Y}/$${_time:%m}/$${_time:%d}/"
    storage_classes        = ["STANDARD"]

  }

  depends_on = [criblio_search_dataset_provider.securityinvestigation_provider]
}
# S3 dataset for Windows powershell event log search  
resource "criblio_search_dataset" "securityinvestigation_windows_powershell" {
  s3_dataset = {
    id                     = "securityinvestigation_windows_powershell"
    type                   = "s3"
    provider_id            = "securityinvestigation_provider"
    filter                 = "dataSource.startsWith('WinEventLog:Microsoft-Windows-PowerShell-Operational') && ['2016','2017','2018'].indexOf(version)>=0"
    description            = "S3 dataset for Windows powershell event logs"
    region                 = var.aws_region
    skip_event_time_filter = true
    bucket                 = "${var.s3_investigation_bucket}/$${version}/$${dataSource}/$${origin_source}/$${host}/$${_time:%Y}/$${_time:%m}/$${_time:%d}/"
    storage_classes        = ["STANDARD"]
  }
  depends_on = [criblio_search_dataset_provider.securityinvestigation_provider]
}
#s3 dataset for aws data sources
resource "criblio_search_dataset" "securityinvestigation_aws" {
  s3_dataset = {
    id                     = "securityinvestigation_aws"
    type                   = "s3"
    provider_id            = "securityinvestigation_provider"
    filter                 = "dataSource.startsWith('aws:') && ['2016','2017','2018'].indexOf(version)>=0"
    description            = "S3 dataset for AWS data sources : the field dataSource tells you which type of source it is. example of dataSource are : aws:s3:accesslogs, aws:rds:audit, aws:rds:error, aws:description, aws:elb:accesslogs, aws:config:rule, aws:cloudwatchlogs, aws:cloudtrail, aws:cloudwatch, aws:cloudwatch:guardduty"

    region                 = var.aws_region
    skip_event_time_filter = true
    bucket                 = "${var.s3_investigation_bucket}/$${version}/$${dataSource}/$${origin_source}/$${host}/$${_time:%Y}/$${_time:%m}/$${_time:%d}/"
    storage_classes        = ["STANDARD"]
  }
  depends_on = [criblio_search_dataset_provider.securityinvestigation_provider]
}
#s3 dataset for access_combined data sources
resource "criblio_search_dataset" "securityinvestigation_access_combined" {
  s3_dataset = {
    id                     = "securityinvestigation_access_combined"
    type                   = "s3"
    provider_id            = "securityinvestigation_provider"
    filter                 = "dataSource.startsWith('access_combined:') && ['2016','2017','2018'].indexOf(version)>=0"
    description            = "S3 dataset for access_combined data sources"
    region                 = var.aws_region
    skip_event_time_filter = true
    bucket                 = "${var.s3_investigation_bucket}/$${version}/$${dataSource}/$${origin_source}/$${host}/$${_time:%Y}/$${_time:%m}/$${_time:%d}/"

    storage_classes        = ["STANDARD"]
  }
  depends_on = [criblio_search_dataset_provider.securityinvestigation_provider]
}
#s3 dataset for apache access logs
resource "criblio_search_dataset" "securityinvestigation_apache_logs" {
  s3_dataset = {
    id                     = "securityinvestigation_apache_logs"
    type                   = "s3"
    provider_id            = "securityinvestigation_provider"
    filter                 = "dataSource.startsWith('apache') && ['2016','2017','2018'].indexOf(version)>=0"
    description            = "S3 dataset for apache  logs"
    region                 = var.aws_region
    skip_event_time_filter = true
    bucket                 = "${var.s3_investigation_bucket}/$${version}/$${dataSource}/$${origin_source}/$${host}/$${_time:%Y}/$${_time:%m}/$${_time:%d}/"
    storage_classes        = ["STANDARD"]
  }
  depends_on = [criblio_search_dataset_provider.securityinvestigation_provider]
}
#s3 dataset for cisco asa data sources
resource "criblio_search_dataset" "securityinvestigation_cisco_asa" {
  s3_dataset = {
    id                     = "securityinvestigation_cisco_asa"
    type                   = "s3"
    provider_id            = "securityinvestigation_provider"
    filter                 = "dataSource.startsWith('cisco:asa') && ['2016','2017','2018'].indexOf(version)>=0"
    description            = "S3 dataset for cisco asa data sources"
    region                 = var.aws_region
    skip_event_time_filter = true
    bucket                 = "${var.s3_investigation_bucket}/$${version}/$${dataSource}/$${origin_source}/$${host}/$${_time:%Y}/$${_time:%m}/$${_time:%d}/"
    storage_classes        = ["STANDARD"]
  }
  depends_on = [criblio_search_dataset_provider.securityinvestigation_provider]
}
#s3 dataset for fortinet data sources
resource "criblio_search_dataset" "securityinvestigation_fortinet" {
  s3_dataset = {
    id                     = "securityinvestigation_fortinet"
    type                   = "s3"
    provider_id            = "securityinvestigation_provider"
    filter                 = "dataSource.startsWith('fgt') && ['2016','2017','2018'].indexOf(version)>=0"
    description            = "S3 dataset for fortinet data sources"
    region                 = var.aws_region
    skip_event_time_filter = true
    bucket                 = "${var.s3_investigation_bucket}/$${version}/$${dataSource}/$${origin_source}/$${host}/$${_time:%Y}/$${_time:%m}/$${_time:%d}/"
    storage_classes        = ["STANDARD"]
  }
  depends_on = [criblio_search_dataset_provider.securityinvestigation_provider]
}
#s3 dataset for stream data sources
resource "criblio_search_dataset" "securityinvestigation_stream" {
  s3_dataset = {
    id                     = "securityinvestigation_stream"
    type                   = "s3"
    provider_id            = "securityinvestigation_provider"
    filter                 = "dataSource.startsWith('stream:') && ['2016','2017','2018'].indexOf(version)>=0"
    description            = "S3 dataset for stream data sources (network capture information)"
    region                 = var.aws_region
    skip_event_time_filter = true
    bucket                 = "${var.s3_investigation_bucket}/$${version}/$${dataSource}/$${origin_source}/$${host}/$${_time:%Y}/$${_time:%m}/$${_time:%d}/"
    storage_classes        = ["STANDARD"]
  }
  depends_on = [criblio_search_dataset_provider.securityinvestigation_provider]
}
#s3 dataset for suricata data sources
resource "criblio_search_dataset" "securityinvestigation_suricata" {
  s3_dataset = {
    id                     = "securityinvestigation_suricata"
    type                   = "s3"
    provider_id            = "securityinvestigation_provider"
    filter                 = "dataSource.startsWith('suricata') && ['2016','2017','2018'].indexOf(version)>=0"
    description            = "S3 dataset for suricata data sources"
    region                 = var.aws_region
    skip_event_time_filter = true
    bucket                 = "${var.s3_investigation_bucket}/$${version}/$${dataSource}/$${origin_source}/$${host}/$${_time:%Y}/$${_time:%m}/$${_time:%d}/"
    storage_classes        = ["STANDARD"]
  }
  depends_on = [criblio_search_dataset_provider.securityinvestigation_provider]
}
#s3 dataset for windows registry data sources
resource "criblio_search_dataset" "securityinvestigation_windows_registry" {
  s3_dataset = {
    id                     = "securityinvestigation_windows_registry"
    type                   = "s3"
    provider_id            = "securityinvestigation_provider"
    filter                 = "dataSource.startsWith('WinRegistry') && ['2016','2017','2018'].indexOf(version)>=0"
    description            = "S3 dataset for windows registry data sources"
    region                 = var.aws_region
    skip_event_time_filter = true
    bucket                 = "${var.s3_investigation_bucket}/$${version}/$${dataSource}/$${origin_source}/$${host}/$${_time:%Y}/$${_time:%m}/$${_time:%d}/"
    storage_classes        = ["STANDARD"]
  }
  depends_on = [criblio_search_dataset_provider.securityinvestigation_provider]
}
