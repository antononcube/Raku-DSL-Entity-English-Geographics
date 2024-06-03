
use lib <. lib>;

use DSL::Entity::Geographics;

my @testCommands = (
'Atlanta',
'Atlanta, GA',
'Fort Lauderdale, FL',
'Fort Lauderdale Florida',
'Chicago Florida',
'Miami Florida',
'Los Angeles',
'las Vegas Nevada',
);


my @targets = <Raku-System>;

for @testCommands -> $c {
    say "=" x 30;
    say $c;
    for @targets -> $t {
        say '-' x 30;
        say $t;
        say '-' x 30;
        my $start = now;
        my $res = entity-city-and-state-name($c, $t);
        say "Result: {$res.raku}";
        say "time:", now - $start;
        say $res;
    }
}
