# DSL::Entity::Geographics


[![MacOS](https://github.com/antononcube/Raku-DSL-Entity-Geographics/actions/workflows/macos.yml/badge.svg)](https://github.com/antononcube/Raku-DSL-Entity-Geographics/actions/workflows/macos.yml)
[![Linux](https://github.com/antononcube/Raku-DSL-Entity-Geographics/actions/workflows/linux.yml/badge.svg)](https://github.com/antononcube/Raku-DSL-Entity-Geographics/actions/workflows/linux.yml)
[![Win64](https://github.com/antononcube/Raku-DSL-Entity-Geographics/actions/workflows/windows.yml/badge.svg)](https://github.com/antononcube/Raku-DSL-Entity-Geographics/actions/workflows/windows.yml)
[![https://raku.land/zef:antononcube/DSL::Entity::Geographics](https://raku.land/zef:antononcube/DSL::Entity::Geographics/badges/version)](https://raku.land/zef:antononcube/DSL::Entity::Geographics)
[![License: Artistic-2.0](https://img.shields.io/badge/License-Artistic%202.0-0298c3.svg)](https://opensource.org/licenses/Artistic-2.0)


Raku grammar classes for geographic entities (names.)

This package is closely related, but independent of 
[Data::Geographics](https://raku.land/zef:antononcube/Data::Geographics), [AAp5].

## Installation

From [Zef ecosystem](https://raku.land):

```
zef install DSL::Entity::Geographics
```

From GitHub:

```
zef install https://github.com/antononcube/Raku-DSL-Entity-Geographics.git
```

## Examples

### Basic entity name retrieval

Here we show how the entity ID is retrieved using an adjective:

```perl6
use DSL::Entity::Geographics;

ToGeographicEntityCode('Brazilian');
```
```
# "Brazil"
```

### Identifiers

The known cities are have identifier in the form: `<country>.<province>.<city>`.
The names in the identifiers have underscore characters ("_") instead of spaces.
For example: 

```
United_States.Nevada.Las_Vegas
```

**Remark:** Both packages "DSL::Entity::Geographics" and "Data::Geographics" have 
the same identifiers. 

### City specs

There is a dedicated function for parsing city names together with a state- or country name:

```perl6
entity-city-and-state-name('Chicago, IL')
```
```
# United_States.Illinois.Chicago
```

If the adverb `:exhaustive` (or just `:ex`) is used then all matches for city name in country (like USA)
are returned:

```perl6
.say for entity-city-and-state-name('Atlanta United States'):ex
```
```
# United_States.Nebraska.Atlanta
# United_States.Louisiana.Atlanta
# United_States.Kansas.Atlanta
# United_States.Illinois.Atlanta
# United_States.Indiana.Atlanta
# United_States.Texas.Atlanta
# United_States.Georgia.Atlanta
# United_States.Michigan.Atlanta
# United_States.Missouri.Atlanta
# United_States.Wisconsin.Atlanta
```

A city name without a specified country or state is considered a generic city name if found in the 
gazeteer database:

```perl6
say entity-city-and-state-name('Miama');
```
```
#ERROR: Possible misspelling of 'miami' as 'miama'.
# CITYNAME.Miami
```

**Remark:** Misspellings are recognized and allowed:

### Grammar parsing

One of the main motivations for this package is to be able to use known country names and related adjectives
as grammar tokens. For example, in packages like ["DSL::English::FoodPreparationWorkflows"](https://github.com/antononcube/Raku-DSL-English-FoodPreparationWorkflows), [AAp4].

Here are few grammar parsing examples:

```perl6
use DSL::Entity::Geographics::Grammar;

my $pCOMMAND = DSL::Entity::Geographics::Grammar.new;

$pCOMMAND.set-resources(DSL::Entity::Geographics::resource-access-object());

say $pCOMMAND.parse('Argentina', rule => 'geographic-entity-command');
```
```
#ERROR: Possible misspelling of 'argentine' as 'argentina'.
# ｢Argentina｣
#  entity-country-adjective => ｢Argentina｣
#   0 => ｢Argentina｣
#    word-value => ｢Argentina｣
```

```perl6
say $pCOMMAND.parse('United States of America', rule => 'geographic-entity-command');
```
```
# ｢United States of America｣
#  entity-country-name => ｢United States of America｣
#   0 => ｢United States of America｣
#    word-value => ｢United｣
#    word-value => ｢States｣
#    word-value => ｢of｣
#    word-value => ｢America｣
```

Again, misspellings are recognized and allowed:

```perl6
say $pCOMMAND.parse('Indianapolia, Indiana', rule => 'entity-city-and-state-name');
```
```
#ERROR: Possible misspelling of 'indianapolis' as 'indianapolia'.
# ｢Indianapolia, Indiana｣
#  entity-city-name => ｢Indianapolia｣
#   0 => ｢Indianapolia｣
#    word-value => ｢Indianapolia｣
#  entity-state-name => ｢Indiana｣
#   0 => ｢Indiana｣
#    word-value => ｢Indiana｣
```


## References

[AAp1] Anton Antonov,
[DSL::Shared Raku package](https://github.com/antononcube/Raku-DSL-Shared),
(2020),
[GitHub/antononcube](https://github.com/antononcube).

[AAp2] Anton Antonov,
[DSL::Entity::Jobs Raku package](https://github.com/antononcube/Raku-DSL-Entity-Jobs),
(2021),
[GitHub/antononcube](https://github.com/antononcube).

[AAp3] Anton Antonov,
[DSL::Entity::Foods Raku package](https://github.com/antononcube/Raku-DSL-Entity-Foods),
(2021),
[GitHub/antononcube](https://github.com/antononcube).

[AAp4] Anton Antonov,
[DSL::English::FoodPreparationWorkflows Raku package](https://github.com/antononcube/Raku-DSL-English-FoodPreparationWorkflows),
(2021),
[GitHub/antononcube](https://github.com/antononcube).

[AAp5] Anton Antonov,
[Data::Geographics Raku package](https://github.com/antononcube/Raku-Data-Geographics),
(2021-2024),
[GitHub/antononcube](https://github.com/antononcube).

