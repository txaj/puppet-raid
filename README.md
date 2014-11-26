Master Branch: [![Build Status](https://secure.travis-ci.org/LarsFronius/puppet-raid.png?branch=master)](http://travis-ci.org/LarsFronius/puppet-raid)
Dev Branch: [![Build Status](https://secure.travis-ci.org/LarsFronius/puppet-raid.png?branch=dev)](http://travis-ci.org/LarsFronius/puppet-raid)

puppet-raid
===========

This is the raid module.

How to use it
-------------

Simply install and `include raid` in your node definition. I will do the rest. Or notice you if I can't do anything for you. Please open issue on github in that case including the output of `facter -p`.

You can check `/usr/sbin/check-raid` afterwards or simply point Nagios NRPE to command `/usr/sbin/check-raid --nagios`.

Don't forget to generate the sudoers configuration. This snippet might help you : 
``
  exec { 'check_raid_setup_sudoers':
    command     => '/usr/lib/nagios/plugins/check_raid -S',
    unless      => 'grep "Lines matching CHECK_RAID added by" /etc/sudoers',
    refreshonly => true,
  }
``

What's configurable?
--------------------

There are some global variables you can set to configure e-mail based monitoring of your RAID.

 * Set `raid_service` to true or false to enable e-mail raid monitoring
 * Set `raid_mailto` to mail address or system user
 * Set `raid_period` to set seconds between checks
 * Set `raid_remind` to set seconds between remind mails
 * Set `raid::params::report_unsupported` to false to avoid being notify{}ed when there is a unsupported device
 * Set `raid::params::report_nodevice` to false to avoid being notify{}ed when there no hardware raid controller detected


puppet version
--------------

Continuosly tested with Puppet Version 2.6.9, 2.7.14, 2.7.19 under Ruby 1.8.7 and JRuby.
