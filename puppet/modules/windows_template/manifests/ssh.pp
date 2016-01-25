class windows_template::ssh (
  $download_base_url = 'http://int-resources.ops.puppetlabs.net/QA_resources/bitvise',
  $temp_path         = 'C:\Windows\Temp',
  $bitvise_installer = 'BvSshServer-Inst.exe',
)
{
  # Init
  $bitvise_download_url  = "${download_base_url}/BvSshServer-Inst.exe"
  $bitvise_download_path = "${temp_path}\\BvSshServer-Inst.exe"
  $ps_download_command   = "(New-Object System.Net.WebClient).DownloadFile(\"${bitvise_download_url}\", \"${bitvise_download_path}\")"

  $license        = file('windows_template/bitvise_license.txt')

  $bitvise_config_name = 'windows_vmpooler_bitvise_settings.wst'
  $bitvise_config_path = "${temp_path}\\${bitvise_config_name}"

  # Download BitVise
  exec { 'download_bitvise':
    command  => $ps_download_command,
    provider => powershell,
    creates  => $bitvise_download_path
  }

  # Create BitVise Config
  file { 'bitvise_config':
    ensure => file,
    path   => $bitvise_config_path,
    source => "puppet:///modules/windows_template/${$bitvise_config_name}",
  }

  # Install BitVise
  package { 'Bitvise SSH Server 6.45 (remove only)':
    ensure          => installed,
    source          => $bitvise_download_path,
    install_options => [
      '-acceptEULA',
      '-defaultInstance',
      '-startService',
      "-activationCode=${$license}",
      "-settings=${bitvise_config_path}",
    ],
    require => [ Exec['download_bitvise'], File['bitvise_config'] ]
  }

  # Start BitVise Service
  # service { 'bitvise_service':
  #   ensure => running,
  #   enable => true,
  #   name   => 'BvSshServer',
  # }
}
