#!/usr/bin/perl

# troiter.pl
# Troy Perkins
# A Simple FreeSWITCH Metric Prometheus Exporter
# >>>> NOT WORKING YET <<<<
# 07/12/2017
#
 use warnings;
 #use strict;
 require ESLi;
 require Net::Prometheus;
 require Time::HiRes; qw( time )

 my $command = shift;
 my $attbs = join(' ', @ARGV);

 if( $attbs eq ' ' || $command eq ' ') {
   print("USAGE: troiter arguments must be\n");
   print("identical to those run via fs_cli >.\n");
 }
 my $con = new ESL::ESLconnection('nyc01b.lab.socom.network', "8021", 'ClueCon');
 my $client = $con -> api('$command', '$attbs');
  $client = Net::Prometheus -> new;
 my $summary = $client -> new_summary (
   name=>'request_seconds',
   help=>'Summary request processing time',
 );

 sub handle_request
 {
   my $start = time();
   print $client->getBody();
   $summary->observe( time() - $start );
 }

