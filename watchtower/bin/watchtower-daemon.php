<?php
// same as scripts/watchtower.php, but more suitable for systemd

if( !array_key_exists( 1, $argv )) {
    throw new RuntimeException( "Systemd instanceName must be provided as argv[1]" );
}
$instanceConfig = $argv[1];
$numberWorkers  = array_key_exists(2, $argv) ? $argv[2] : 4;

if( file_exists( $instanceConfig )) {
    require( $instanceConfig );
    // this file will change the directory into the correct place

} else {
    throw new RuntimeException( "Instance configuration file not found: " + $instanceConfig );
}

include('vendor/autoload.php');

q()->run_workers( $numberWorkers );
