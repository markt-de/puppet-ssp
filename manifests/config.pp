# A description of what this class does
#
#  Config file for SSP config file
#
#  This code can be enable/disabled if you want.
#
#  - Mode (Permission of Folder and Files)
#  - template is written in EPP
#  - service will be reloaded with notify 
#  - config File be installed, if there are exsisting packages 
#
#   include ssp::config
class ssp::config {
  if $ssp::config_manage {
    file { $ssp::config_file:
      ensure  => file,
      mode    => $ssp::config_mode,
      content => epp($ssp::config_template),
      owner   => $ssp::user,
      group   => $ssp::group,
#     notify  => Class['ssp::service'],
#     require => Class['ssp::package'],
    }
  }
}
