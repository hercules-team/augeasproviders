# Class: augeasproviders::instances: See README.md for documentation
#
# [Remember: No empty lines between comments and class definition]
class augeasproviders::instances (
  $apache_directive_hash      = $augeasproviders::params::apache_directive_hash,
  $apache_setenv_hash         = $augeasproviders::params::apache_setenv_hash,
  $host_hash                  = $augeasproviders::params::host_hash,
  $kernel_parameter_hash      = $augeasproviders::params::kernel_parameter_hash,
  $mailalias_hash             = $augeasproviders::params::mailalias_hash,
  $mounttab_hash              = $augeasproviders::params::mounttab_hash,
  $nrpe_command_hash          = $augeasproviders::params::nrpe_command_hash,
  $pam_hash                   = $augeasproviders::params::pam_hash,
  $pg_hba_hash                = $augeasproviders::params::pg_hba_hash,
  $puppet_auth_hash           = $augeasproviders::params::puppet_auth_hash,
  $shellvar_hash              = $augeasproviders::params::shellvar_hash,
  $ssh_config_hash            = $augeasproviders::params::ssh_config_hash,
  $sshd_config_hash           = $augeasproviders::params::sshd_config_hash,
  $sshd_config_subsystem_hash = $augeasproviders::params::sshd_config_subsystem_hash,
  $sysctl_hash                = $augeasproviders::params::sysctl_hash,
  $syslog_hash                = $augeasproviders::params::syslog_hash,
  $resource_defaults          = $augeasproviders::params::resource_defaults
) inherits augeasproviders::params {

  validate_hash($resource_defaults)

  if $apache_directive_hash and !empty($apache_directive_hash) {
    validate_hash($apache_directive_hash)
    create_resources(apache_directive, $apache_directive_hash, $resource_defaults['apache_directive'])
  }

  if $apache_setenv_hash and !empty($apache_setenv_hash) {
    validate_hash($apache_setenv_hash)
    create_resources(apache_setenv, $apache_setenv_hash, $resource_defaults['apache_setenv'])
  }

  if $host_hash and !empty($host_hash) {
    validate_hash($host_hash)
    create_resources(host, $host_hash, $resource_defaults['host'])
  }

  if $kernel_parameter_hash and !empty($kernel_parameter_hash) {
    validate_hash($kernel_parameter_hash)
    create_resources(kernel_parameter, $kernel_parameter_hash, $resource_defaults['kernel_parameter'])
  }

  if $mailalias_hash and !empty($mailalias_hash) {
    validate_hash($mailalias_hash)
    create_resources(mailalias, $mailalias_hash, $resource_defaults['mailalias'])
  }

  if $mounttab_hash and !empty($mounttab_hash) {
    validate_hash($mounttab_hash)
    create_resources(mounttab, $mounttab_hash, $resource_defaults['mounttab'])
  }

  if $nrpe_command_hash and !empty($nrpe_command_hash) {
    validate_hash($nrpe_command_hash)
    create_resources(nrpe_command, $nrpe_command_hash, $resource_defaults['nrpe_command'])
  }

  if $pam_hash and !empty($pam_hash) {
    validate_hash($pam_hash)
    create_resources(pam, $pam_hash, $resource_defaults['pam'])
  }

  if $pg_hba_hash and !empty($pg_hba_hash) {
    validate_hash($pg_hba_hash)
    create_resources(pg_hba, $pg_hba_hash, $resource_defaults['pg_hba'])
  }

  if $puppet_auth_hash and !empty($puppet_auth_hash) {
    validate_hash($puppet_auth_hash)
    create_resources(puppet_auth, $puppet_auth_hash, $resource_defaults['puppet_auth'])
  }

  if $shellvar_hash and !empty($shellvar_hash) {
    validate_hash($shellvar_hash)
    create_resources(shellvar, $shellvar_hash, $resource_defaults['shellvar'])
  }

  if $ssh_config_hash and !empty($ssh_config_hash) {
    validate_hash($ssh_config_hash)
    create_resources(ssh_config, $ssh_config_hash, $resource_defaults['ssh_config'])
  }

  if $sshd_config_hash and !empty($sshd_config_hash) {
    validate_hash($sshd_config_hash)
    create_resources(sshd_config, $sshd_config_hash, $resource_defaults['sshd_config'])
  }

  if $sshd_config_subsystem_hash and !empty($sshd_config_subsystem_hash) {
    validate_hash($sshd_config_subsystem_hash)
    create_resources(sshd_config_subsystem, $sshd_config_subsystem_hash, $resource_defaults['sshd_config_subsystem'])
  }

  if $sysctl_hash and !empty($sysctl_hash) {
    validate_hash($sysctl_hash)
    create_resources(sysctl, $sysctl_hash, $resource_defaults['sysctl'])
  }

  if $syslog_hash and !empty($syslog_hash) {
    validate_hash($syslog_hash)
    create_resources(syslog, $syslog_hash, $resource_defaults['syslog'])
  }

}
