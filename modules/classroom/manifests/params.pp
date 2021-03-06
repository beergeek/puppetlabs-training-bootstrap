class classroom::params {
  # Configure NTP (and other services) to run in standalone mode
  $offline   = false

  # Automatically configure environment, etc for students.
  $autosetup = false

  # automatically assign teams for the capstone
  $autoteam  = false

  # list of classes that should be available in the console
  $classes   = [ 'users', 'apache', 'userprefs' ]

  # Name of the student's working directory
  $workdir   = 'puppetcode'

  # default user password
  $password  = '$1$Tge1IxzI$kyx2gPUvWmXwrCQrac8/m0' # puppetlabs
  $consolepw = 'puppetlabs'

  # Should we manage upstream yum repositories in the classroom?
  $manageyum = true

  # Upstream yum repositories
  $repositories = [ 'base', 'extras', 'updates', 'epel' ]

  # manage git repositories for the student and the master
  $managerepos = true

  # time servers to use if we've got network
  $time_servers = ['0.pool.ntp.org iburst', '1.pool.ntp.org iburst', '2.pool.ntp.org iburst', '3.pool.ntp.org']

  # is this a student's tier3 agent in Architect?
  if $domain != 'puppetlabs.vm' {
    $role = 'tier3'
  }
  else {
    $role = $hostname ? {
      /^master|classroom$/ => 'master',
      'proxy'            => 'proxy',
      default            => 'agent'
    }
  }

  $download = "\n\nPlease download a new VM: http://downloads.puppetlabs.com/training/\n\n"
  if versioncmp($::classroom_vm_release, '2.5') < 0 {
    fail("Your VM is out of date. ${download}")
  }

  if versioncmp($::pe_version, '3.2.0') < 0 {
    fail("Your Puppet Enterprise installation is out of date. ${download}")
  }
}
