# @summary Setup LDAP Account Manager (SSP)
#
# @param config
#   This config Hash will be used in config.inc.local.epp
#
# @param config_file
#   The path of the duplicate of the common ssp config file
#   Specifies lookup for the installroot and ersion 
#
# @param config_manage
#   You can enable/disable this funcion if you want to 
#
# @param config_mode
#   Folder permission
#
# @param config_template
#   The location of the local config.inc.local.epp file
#
# @param edition
#   The edition of SSP that should be installed.
#
# @param group
#   The name of the group that is used by the webserver process.
#
# @param installroot
#   Specifies the base directory where SSP should be installed. A new
#   subdirectory for each version will be created.
#
# @param manage_symlink
#   You can enable/disable this symlink funcion if you want to 
#
# @param symlink_name
#   Create a symlink that points to the current version.
#
# @param mirror
#   Specifies the base URL where the distribution archive can be downloaded.
#   Useful when providing a local mirror for the Pro edition.
#
# @param user
#   The name of the user that is used by the webserver process.
#
# @param version
#   Specifies the version of SSP that should be installed.
# 
# @param smarty_path
#     
# 
#
class ssp (
  Hash $config,
  String $config_file,
  Boolean $config_manage,
  String $config_mode,
  String $config_template,
  Enum['oss', 'pro'] $edition,
  String $group,
  Stdlib::Compat::Absolute_path $installroot,
  Boolean $manage_symlink,
  Variant[Stdlib::HTTPUrl,Stdlib::HTTPSUrl] $mirror,
  String $symlink_name,
  String $user,
  String $version,
  Optional[String] $smarty_path = undef,
) {
  class { 'ssp::install': }
  -> class { 'ssp::config': }
}
