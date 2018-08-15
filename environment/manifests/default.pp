node puppetmaster {
  include ntp
  include firewall
  include remote_environments
  include server
}

node default {
  include agent
}
