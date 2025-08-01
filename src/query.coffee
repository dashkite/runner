import * as Fn from "@dashkite/joy/function"

class Query

  @matching: ( name ) ->
    ( scenarios ) -> 
      scenarios
        ?.find ( scenario ) -> scenario.name == name
        ?.scenarios

  @children: ( scenarios ) ->
    scenarios?.filter ( scenario ) -> !scenario.scenarios?

  @descendents: ( scenarios ) ->
    result = []
    if scenarios?
      for scenario in scenarios
        if scenario.scenarios?
          result = [ 
            result...
            ( Query.descendents scenario.scenarios )...
          ]
        else
          result.push scenario
    result

  @build: ( path ) ->
    result = []
    for item in path
      switch item
        when "*"
          result.push Query.children
        when "**"
          result.push Query.descendents
        else
          result.push Query.matching item
    Object.assign ( new @ ), query: Fn.pipe result

  apply: ( target ) -> @query target

export default Query