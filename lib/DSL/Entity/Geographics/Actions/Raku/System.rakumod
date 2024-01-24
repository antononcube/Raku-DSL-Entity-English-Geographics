use DSL::Entity::Geographics::Grammar;
use DSL::Shared::Actions::English::Raku::PipelineCommand;
use DSL::Entity::Geographics::ResourceAccess;
use DSL::Shared::Entity::Actions::Raku::System;


class DSL::Entity::Geographics::Actions::Raku::System
        is DSL::Shared::Entity::Actions::Raku::System
        is DSL::Shared::Actions::English::Raku::PipelineCommand {

    has DSL::Entity::Geographics::ResourceAccess $.resources;

    ##========================================================
    ## Grammar methods
    ##========================================================

    method TOP($/) {
        make $/.values[0].made;
    }

    method geographic-entity-command($/) {
        make $/.values[0].made;
    }

    #------------------------------------------------------
    method entity-country-name:sym<English>($/) {
        my $name = $!resources.name-to-entity-id('Country', $/.Str.lc, :!bool, :!warn);
        make $name;
    }

    method entity-country-name:sym<Bulgarian>($/) {
        my $name = $!resources.name-to-entity-id('Country-Bulgarian', $/.Str.lc, :!bool, :!warn);
        make $name;
    }

    #------------------------------------------------------
    method entity-country-adjective:sym<English>($/) {
        my $adj = $!resources.name-to-entity-id('Country-Adjective', $/.Str.lc, :!bool, :!warn);
        make $adj;
    }

    method entity-country-adjective:sym<Bulgarian>($/) {
        my $adj = $!resources.name-to-entity-id('Country-Adjective-Bulgarian', $/.Str.lc, :!bool, :!warn);
        make $adj;
    }

    #------------------------------------------------------
    method entity-region-name:sym<English>($/) {
        my $adj = $!resources.name-to-entity-id('Region', $/.Str.lc, :!bool, :!warn);
        make $adj;
    }

    method entity-region-name:sym<Bulgarian>($/) {
        my $adj = $!resources.name-to-entity-id('Region-Bulgarian', $/.Str.lc, :!bool, :!warn);
        make $adj;
    }

    #------------------------------------------------------
    method entity-region-adjective:sym<English>($/) {
        my $adj = $!resources.name-to-entity-id('Region-Adjective', $/.Str.lc, :!bool, :!warn);
        make $adj;
    }

    method entity-region-adjective:sym<Bulgarian>($/) {
        my $adj = $!resources.name-to-entity-id('Region-Adjective-Bulgarian', $/.Str.lc, :!bool, :!warn);
        make $adj;
    }

    #------------------------------------------------------
    method entity-state-name:sym<English>($/) {
        my $adj = $!resources.name-to-entity-id('State', $/.Str.lc, :!bool, :!warn);
        make $adj;
    }

    method entity-state-name:sym<Bulgarian>($/) {
        my $adj = $!resources.name-to-entity-id('State-Bulgarian', $/.Str.lc, :!bool, :!warn);
        make $adj;
    }

    #------------------------------------------------------
    method entity-city-name:sym<English>($/) {
        # There should be name clashes.
        # Selection has to be done based on city population.
        # (That data is not included in this package yet.)
        my $name = $!resources.name-to-entity-id('City', $/.Str.lc, :!bool, :!warn);
        make $name;
    }

    method entity-city-name:sym<Bulgarian>($/) {
        my $name = $!resources.name-to-entity-id('City-Bulgarian', $/.Str.lc, :!bool, :!warn);
        make $name;
    }

    #------------------------------------------------------
    method entity-city-and-state-name($/) {
        if !$<entity-state-name>.defined {
            # Here we should find the most populous city across all states and all countries.
            # Right now those most populous cities are hard-coded in the CityNameToEntityID_EN.csv .
            make $<entity-city-name>.made;
        } elsif $<entity-city-name>.made.contains($<entity-state-name>.made.subst('"'):g) {
            make $<entity-city-name>.made;
        } else {
            # This should be refactored to use the _code_ of the functions:
            #   interpret-geographics-id and make-geographics-id from Data::Geographics
            # instead of using ad hoc the following implementation.

            # Here we assume that the IDs are in the form <country>.<state>.<city>
            my $state = $<entity-state-name>.made.split('.').tail.trans(['"', '_'] => ['', ' ']);
            my $city = $<entity-city-name>.made.split('.').tail.trans(['"', '_'] => ['', ' ']);

            my @set = $!resources.countryStateCity{$!resources.defaultCountry.subst('_', ' '):g ; $state ; $city }.grep(*.defined);
            if @set {
                make "{$!resources.defaultCountry}.{$state.subst(' ', '_'):g}.{$city.subst(' ', '_'):g}";
            } else {
                make 'NONE';
            }
        }
    }
}
