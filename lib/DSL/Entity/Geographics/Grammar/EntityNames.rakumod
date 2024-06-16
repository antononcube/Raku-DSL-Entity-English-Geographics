role DSL::Entity::Geographics::Grammar::EntityNames {

    #------------------------------------------------------
    proto regex entity-country-adjective {*}

    regex entity-country-adjective:sym<English> {
        (<word-value>+ % \h+ ) <?{ self.get-resources().known-name( 'Country-Adjective', $0.Str.lc) }>
    }

    regex entity-country-adjective:sym<Bulgarian> {
        (<word-value>+ % \h+ ) <?{ self.get-resources().known-name( 'Country-Adjective-Bulgarian', $0.Str.lc) }>
    }

    #------------------------------------------------------
    proto regex entity-region-adjective {*}

    regex entity-region-adjective:sym<English> {
        (<word-value>+ % \h+ ) <?{ self.get-resources().known-name( 'Region-Adjective', $0.Str.lc) }>
    }

    regex entity-region-adjective:sym<Bulgarian> {
        (<word-value>+ % \h+ ) <?{ self.get-resources().known-name( 'Region-Adjective-Bulgarian', $0.Str.lc) }>
    }

    #------------------------------------------------------
    proto regex entity-country-name {*}

    regex entity-country-name:sym<English> {
        ( <word-value>+ % \h+ ) <?{ self.get-resources().known-name('Country', $0.Str.lc) }>
    }

    regex entity-country-name:sym<Bulgarian> {
        ( <word-value>+ % \h+ ) <?{ self.get-resources().known-name('Country-Bulgarian', $0.Str.lc) }>
    }

    #------------------------------------------------------
    proto regex entity-region-name {*}

    regex entity-region-name:sym<English> {
        ( <word-value>+ % \h+ ) <?{ self.get-resources().known-name('Region', $0.Str.lc) }>
    }

    regex entity-region-name:sym<Bulgarian> {
        ( <word-value>+ % \h+ ) <?{ self.get-resources().known-name('Region-Bulgarian', $0.Str.lc) }>
    }

    #------------------------------------------------------
    proto regex entity-state-name {*}

    regex entity-state-name:sym<English> {
        ( <word-value>+ % \h+ ) <?{ self.get-resources().known-name('State', $0.Str.lc) }>
    }

    regex entity-state-name:sym<Bulgarian> {
        ( <word-value>+ % \h+ ) <?{ self.get-resources().known-name('State-Bulgarian', $0.Str.lc) }>
    }

    #------------------------------------------------------
    proto regex entity-city-name {*}

    regex entity-city-name:sym<English> {
        ( <word-value>+ % \h+ ) <?{ self.get-resources().known-name('City', $0.Str.lc) }>
    }

    regex entity-city-name:sym<Bulgarian> {
        ( <word-value>+ % \h+ ) <?{ self.get-resources().known-name('City-Bulgarian', $0.Str.lc) }>
    }

    #------------------------------------------------------
    regex entity-city-and-state-name { <entity-city-name> [ [\s*','? \s* | \s+] <entity-state-name> ]? [ [\s*','?\s* | \s+] <entity-country-name> ]?}
}