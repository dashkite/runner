import { inspect } from "node:util"
import { elide } from "@dashkite/joy/text"
import assert from "@dashkite/assert"
import CoffeeScript from "coffeescript"

debug = ( process.env.debug? || process.env.DEBUG? )

format = ( value ) ->
  elide 30, "...", inspect value

Scenario =

  verify: ( scenario, $ ) ->
    for assertion in scenario.assertions
      do ( assertion, { result } = {}) ->
        try
          result = eval CoffeeScript.compile assertion.path, bare: true
          if assertion.type?
            switch assertion.type
              when "regexp"
                assert ( result.constructor == RegExp )
                assert ( result.toString() == assertion.expect )
              else
                assert[ assertion.type ] assertion.expect, result
          else
            assert result
        catch error
          console.error error if debug
          if assertion.type?
            relation = switch assertion.type
              when "equal" then "=="
              when "regexp" then "matches"
              else assertion.type
            
            error = new Error "assertion failed: 
              [ #{ assertion.path } ] #{ relation }
              #{ format assertion.expect },
              got #{ format result }"
          else
            error = new Error "assertion failed: 
              #{ assertion.path }"
          throw error

export default Scenario