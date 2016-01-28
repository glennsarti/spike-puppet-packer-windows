class windows_template {
  #include windows_template::ssh
  include windows_template::local_group_policies
  include windows_template::disable_services
  include windows_template::vagrant
}
