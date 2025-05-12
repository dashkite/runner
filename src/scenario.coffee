import assert from "@dashkite/assert"
import CoffeeScript from "coffeescript"

debug = ( process.env.debug? || process.env.DEBUG? )

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
          if debug == true
            console.error "assertion failed: [ #{ assertion.path } ]"
            console.error "context ($):\n", $
          throw error

export default Scenario