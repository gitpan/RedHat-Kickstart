use lib qw(. blib/lib t);
use strict;
use RedHat::SysConfig;
use T;
use Carp;
$SIG{__WARN__} = \&Carp::cluck;
 
my $t = T->new();

eval "use RedHat::XML";

if( $@ ) {
  $t->skip('RedHat::XML not installed');
}

my $x = new RedHat::XML();

$x->inst_type( {
   inst_type	=> 'nfs',
   nfsserver	=> 'foo:/bar'
  } );

$t->eok( $x->{settings}->{inst_type}->{inst_type} eq 'nfs',
         "failed to set value" );

my( $k ) = ${ $x->xml( '700' ) };
my @k = split "\n", $k;

$t->eok( $#k, "didn't generate xml file" );

$t->done;



