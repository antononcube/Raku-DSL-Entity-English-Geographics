#!/usr/bin/env perl6
use Geographics;

sub MAIN(Str $commands, Str $target = 'WL-System' ) {
    put ToGeographicEntityCode($commands, $target);
}