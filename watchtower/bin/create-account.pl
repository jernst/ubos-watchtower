#!/usr/bin/perl
#
# Create a MediaWiki admin user.
#
# Copyright (C) 2014 and later, Indie Computing Corp. All rights reserved. License: see package.
#

use strict;

use UBOS::Databases::MySqlDriver;
use UBOS::Logging;
use UBOS::Utils;

my $ret = 1;

if( 'install' eq $operation ) {
    my $appConfigId = $config->getResolveOrNull( 'appconfig.appconfigid' );
    my $userUrl     = $config->getResolve( 'installable.customizationpoints.userurl.value' );
    my $userToken   = $config->getResolve( 'installable.customizationpoints.usertoken.value' );

    my( $dbName, $dbHost, $dbPort, $dbUser, $dbPassword, $dbCredentialType )
            = UBOS::ResourceManager::findProvisionedDatabaseFor(
                    'mysql', $appConfigId, 'watchtower', 'maindb' );

    my $dbh = UBOS::Databases::MySqlDriver::dbConnect( $dbName, $dbUser, $dbPassword, $dbHost, $dbPort );

    UBOS::Databases::MySqlDriver::sqlPrepareExecute(
            $dbh,
            <<SQL,
INSERT INTO users  (url, token, created_at) values ( ?, ?, now() );
SQL
            $userUrl,
            $userToken );
}

$ret;
