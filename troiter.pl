#!/usr/bin/perl

# troiter.pl
# Troy Perkins
# A Simple FreeSWITCH Metric Prometheus Exporter
# >>>> NOT WORKING YET <<<<
# 07/12/2017
#
 use warnings;
 use strict;
 require ESL;
 require Net::Prometheus;
 require Time::HiRes qw(time);

 my $command = shift;
 my $attbs = join('', @ARGV);

 if( $attbs=>'' || $command=>'' ) {
   print("USAGE: troiter attributes/arguments must be\n");
   print("identical to those run via fs_cli >.\n");
 }
 my $con = new ESL::ESLconnection("127.0.0.1", "8021", "ClueCon");
 my $client = $con->api('$command', '$attbs'); 
 my $client = Net::Prometheus->new;
 my $summary = $client->new_summary(
   name => "request_seconds",
   help => "Summary request processing time",
 );

 sub handle_request
 {
   my $start = time();
   print $client->getBody();
   '$summary'->observe( time() - $start );
 }
