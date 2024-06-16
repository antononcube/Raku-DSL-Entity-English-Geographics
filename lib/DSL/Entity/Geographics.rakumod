
=begin pod

=head1 DSL::Entity::Geographics

C<DSL::Entity::Geographics> package has grammar and action classes for the parsing and
interpretation of natural language commands that specify geographic locations.

=head1 Synopsis

    use DSL::Entity::Geographics;
    my $rcode = ToGeographicEntityCode('Argentina');

=end pod

unit module DSL::Entity::Geographics;

use DSL::Shared::Utilities::CommandProcessing;

use DSL::Entity::Geographics::Grammar;
use DSL::Entity::Geographics::Actions::Raku::System;
use DSL::Entity::Geographics::Actions::WL::Entity;
use DSL::Entity::Geographics::Actions::WL::System;

use DSL::Entity::Geographics::Actions::Bulgarian::Standard;

#-----------------------------------------------------------
my %targetToAction =
    "Mathematica"      => DSL::Entity::Geographics::Actions::WL::System,
    "Raku"             => DSL::Entity::Geographics::Actions::Raku::System,
    "Raku-System"      => DSL::Entity::Geographics::Actions::Raku::System,
    "WL"               => DSL::Entity::Geographics::Actions::WL::System,
    "WL-System"        => DSL::Entity::Geographics::Actions::WL::System,
    "WL-Entity"        => DSL::Entity::Geographics::Actions::WL::Entity,
    "Bulgarian"        => DSL::Entity::Geographics::Actions::Bulgarian::Standard;


my %targetToAction2{Str} = %targetToAction.grep({ $_.key.contains('-') }).map({ $_.key.subst('-', '::').Str => $_.value }).Hash;
%targetToAction = |%targetToAction , |%targetToAction2;

#| Target to separators rules
my Str %targetToSeparator{Str} = DSL::Shared::Utilities::CommandProcessing::target-separator-rules();

#-----------------------------------------------------------
my DSL::Entity::Geographics::ResourceAccess $resourceObj;

#| Get the resources access object.
our sub resource-access-object(--> DSL::Entity::Geographics::ResourceAccess)  { return $resourceObj; }

#-----------------------------------------------------------
#| Named entity recognition for  geographical locations.
proto ToGeographicEntityCode(Str $command, Str $target = 'WL-System', | ) is export {*}

#| Named entity recognition for geographical locations.
multi ToGeographicEntityCode( Str $command, Str $target = 'WL-System',  Bool :ex(:$exhaustive) = False, *%args ) {

    my $pCOMMAND = DSL::Entity::Geographics::Grammar;
    $pCOMMAND.set-resources(DSL::Entity::Geographics::resource-access-object());

    my $ACTOBJ = %targetToAction{$target}.new(resources => DSL::Entity::Geographics::resource-access-object());

    my $res = DSL::Shared::Utilities::CommandProcessing::ToWorkflowCode( $command,
                                                               grammar => $pCOMMAND,
                                                               actions => $ACTOBJ,
                                                               separator => %targetToSeparator{$target},
                                                               |%args );

    # Note that if ToWorkflowCode does not obtain a list of strings from parsing the command lines
    # then it returns a list of the interpretations of those command lines.
    if $res ~~ Str:D {
        return $res;
    } else {
        # This means more than one city is found, e.g. "Atlanta, United States".
        # We pick the most populous one except if :exhaustive is true.
        if !($res.all ~~ Map:D) {
            note 'Unexpected interpretation result';
            return $res;
        }
        return do if $exhaustive {
            $res.map({ $_.keys }).flat.List
        } else {
            $res.map({ $_.pairs }).flat.sort(*.value).tail.key
        }
    }
}

#| Named entity recognition for city and state names.
sub entity-city-and-state-name(Str $command, Str $target = 'WL-System', *%args) is export {
    my %args2 = %args.grep({ $_.key ∉ <rule> });
    return ToGeographicEntityCode($command, $target, rule => 'entity-city-and-state-name', |%args2);
}

#-----------------------------------------------------------
$resourceObj := BEGIN {
    my DSL::Entity::Geographics::ResourceAccess $obj .= new;
    $obj.ingest-resource-files();
    $obj
}