# @summary Configuration of Self Service Password
# 
class ssp::config {
  if $ssp::config_manage {
    file { "${ssp::installroot}/self-service-password-${ssp::version}/${ssp::config_file}":
      ensure  => file,
      mode    => $ssp::config_mode,
      content => epp($ssp::config_template),
      owner   => $ssp::user,
      group   => $ssp::group,
    }
  }
}
