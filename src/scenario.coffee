import assert from "@dashkite/assert"
import CoffeeScript from "coffeescript"


Scenario =

  verify: ( scenario, $ ) ->
    for assertion in scenario.assertions
      do ( assertion, { result } = {}) ->
        result = eval CoffeeScript.compile assertion.path, bare: true
        try
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
          if scenario.debug == true
            console.error "assertion failed: [ #{ assertion.path } ]"
            console.error "context ($):\n", $
          throw error

export default Scenario