# @summary Download and extract the distribution archive
# @api private
class ssp::install {
  assert_private()

  include 'archive'

  $archive_name = "self-service-password-${ssp::version}.tar.gz"
  $download_url = sprintf($ssp::mirror, $ssp::version)
  $install_dir = "${ssp::installroot}/self-service-password-${ssp::version}"

  # Archive unzip
  archive { "${ssp::installroot}/${archive_name}":
    source       => $download_url,
    extract      => true,
    extract_path => $ssp::installroot,
    creates      => $install_dir,
    cleanup      => false,
  }

  # install PHP Smarty from local repo
  if ($ssp::manage_smarty) {
    package { $ssp::smarty_package_name:
      ensure => installed,
    }
  }

  # Create a symlink to the current version
  if ($ssp::manage_symlink) {
    file { "${ssp::installroot}/${ssp::symlink_name}":
      ensure  => link,
      target  => $install_dir,
      require => [
        Archive["${ssp::installroot}/${archive_name}"],
      ],
    }
  }
}
