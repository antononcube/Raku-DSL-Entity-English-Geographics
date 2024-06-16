=begin comment
#==============================================================================
#
#   Georaphics entities grammar in Raku
#   Copyright (C) 2021  Anton Antonov
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#   Written by Anton Antonov,
#   antononcube @ posteo . net,
#   Windermere, Florida, USA.
#
#==============================================================================
#
#   For more details about Raku see https://raku.org/ .
#
#==============================================================================
=end comment

use DSL::Shared::Entity::Grammar::EntityNames;
use DSL::Shared::Roles::ErrorHandling;
use DSL::Shared::Roles::English::PipelineCommand;
use DSL::Entity::Geographics::ResourceAccess;
use DSL::Entity::Geographics::Grammar::EntityNames;

grammar DSL::Entity::Geographics::Grammar
        does DSL::Entity::Geographics::Grammar::EntityNames
        does DSL::Shared::Entity::Grammar::EntityNames
        does DSL::Shared::Roles::English::PipelineCommand
        does DSL::Shared::Roles::ErrorHandling {

    my DSL::Entity::Geographics::ResourceAccess $resources;

    method get-resources(--> DSL::Entity::Geographics::ResourceAccess) { return $resources; }
    method set-resources(DSL::Entity::Geographics::ResourceAccess $obj) { $resources = $obj; }

    # TOP
    rule TOP {
        <pipeline-command> |
        <geographic-entity-command> |
        <data-query-command>
    }

    regex geographic-entity-command {
        | <entity-country-adjective>
        | <entity-country-name>
        | <entity-region-adjective>
        | <entity-region-name>
        | <entity-state-name>
        | <entity-city-and-state-name>
    }

    rule geographic-entity-type  { 'counties' | 'cities' | 'states' | 'people' }

    rule data-query-command { [ 'how' 'many' | 'what' 'count' ] <geographic-entity-type> [ 'is' | 'are' ]? [ 'in' | 'at' ] <geographic-entity-command> }

}

