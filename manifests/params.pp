class raid::params (
  $report_unsupported = true,
  $report_nodevice = true,
){
  if !$controller_0_vendor and $::raid_bus_controller_0_vendor {
    $controller_0_vendor = $::raid_bus_controller_0_vendor
    $controller_0_device = $::raid_bus_controller_0_device
  }

  if !$controller_0_vendor and $::serial_attached_scsi_controller_0_vendor {
    $controller_0_vendor = $::serial_attached_scsi_controller_0_vendor
    $controller_0_device = $::serial_attached_scsi_controller_0_device
  }

  case $controller_0_vendor {
    /^LSI/: {
      case $controller_0_device {
        'LSI MegaSAS 9260', 'MegaRAID SAS TB',
        'MegaRAID SAS 2208 [Thunderbolt]': {
          $packages = [ 'megaclisas-status', 'megacli' ]
          $nagioscheck = [ '/usr/sbin/megaclisas-status' ]
          $service = 'megaclisas-statusd'
        }
        'SAS2008 PCI-Express Fusion-MPT SAS-2 [Falcon]': {
          $packages = [ 'sas2ircu-status', 'sas2ircu' ]
          $nagioscheck = [ '/usr/sbin/sas2ircu-status' ]
          $service = 'sas2ircu-statusd'
        }
        default: {
          if ($report_unsupported) {
            notify {
              "Unsupported RAID Device: ${controller_0_device}":
            }
          }
        }
      }
    }
    /^Hewlett-Packard Company/:{
      case $controller_0_device {
        'Smart Array Gen8 Controllers': {
          $packages = [ 'cciss-vol-status', 'hpacucli' ]
          $nagioscheck = [ '/usr/sbin/cciss_vol_status' ]
          $service = 'cciss-vol-statusd'
        }
        default: {
          if ($report_unsupported) {
            notify {
              "Unsupported RAID Device: ${controller_0_device}":
            }
          }
        }
      }
    }
    /^Intel Corporation$/:{
      case $controller_0_device {
        /^C602/: {
          # Software RAID chipset
        }
        default: {
          if ($report_unsupported) {
            notify {
              "Unsupported RAID Device: ${controller_0_device}":
            }
          }
        }
      }
    }
    default: {
      if ($report_unsupported) {
        notify { "Unsupported RAID Vendor: ${controller_0_vendor}": }
      }
    }
    undef: {
      if ($report_nodevice) {
        notify { 'No RAID Controller found': }
      }
    }
  }
}
