class classroom::course::virtual::fundamentals (
  $control_owner      = $classroom::params::control_owner,
  $offline            = $classroom::params::offline,
  $session_id         = $classroom::params::session_id,
  $jvm_tuning_profile = $classroom::params::jvm_tuning_profile,
  $use_gitea          = $classroom::params::use_gitea,
  $event_id           = undef,
  $event_pw           = undef,
  $version            = undef,
) inherits classroom::params {
  class { 'classroom::virtual':
    offline            => $offline,
    use_gitea          => $use_gitea,
    jvm_tuning_profile => $jvm_tuning_profile,
    control_owner      => $control_owner,
    control_repo       => 'classroom-control-vf.git',
    event_id           => $event_id,
    event_pw           => $event_pw,
  }

  if $role == 'master' {
    class { 'classroom::facts':
      coursename => 'fundamentals',
    }

    class { 'classroom::master::showoff':
      course             => 'VirtualFundamentals',
      event_id           => $event_id,
      event_pw           => $event_pw,
      variant            => 'virtual',
      version            => $version,
    }
  }
}
