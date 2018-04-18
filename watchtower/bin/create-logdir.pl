#!/usr/bin/perl
#
# Sets up the logging directory
#
# Copyright (C) 2017 and later, Indie Computing Corp. All rights reserved. License: see package.
#

use strict;
use warnings;

use UBOS::Logging;
use UBOS::Utils;

my $appconfigid = $config->getResolve( 'appconfig.appconfigid' );
my $appid       = $config->getResolve( 'appconfig.appid' );

my $logDir  = "/var/log/$appid/$appconfigid";

if( $operation eq 'deploy' ) {
    unless( -d $logDir ) {
        UBOS::Utils::mkdirDashP( $logDir, 0755, 'http', 'http' );
    }
}

1;
