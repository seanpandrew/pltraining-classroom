class classroom::course::virtual::code_management (
  $session_id = $classroom::params::session_id,
  $role = $classroom::params::role,
) inherits classroom::params {
 
  include r10k::mcollective
  include puppet_enterprise::profile::mcollective::peadmin
  
  if $role == 'master' {
    class { 'puppetfactory':
      # Put students' puppetcode directories somewhere less distracting
      puppetcode => '/var/opt/puppetcode',
      session_id       => $session_id,
    }

    class { 'r10k':
      remote => 'https://github.com/puppetlabs-education/classroom-control.git',
    }
  } else {
    include r10k
  }
}
