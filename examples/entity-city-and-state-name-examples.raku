
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
'Chicago United States',
'Atlanta United States'
);

my @targets = <Raku-System>;
my $exhaustive = False;

for @testCommands -> $c {
    say "=" x 30;
    say $c;
    for @targets -> $t {
        say '-' x 30;
        say $t;
        say '-' x 30;
        my $start = now;
        my $res = entity-city-and-state-name($c, $t, :$exhaustive);
        say "Result: {$res.raku}";
        say "time:", now - $start;
        say $res;
    }
}