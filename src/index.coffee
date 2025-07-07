import * as Amen from "@dashkite/amen"
import RunMap from "./run-map"
import Scenario from "./scenario"
import assert from "@dashkite/assert"

debug = ( process.env.debug? || process.env.DEBUG? )

run = ( scenarios, map ) ->
  for scenario in scenarios
    await do ( scenario ) ->
      Amen.test scenario.name, 
        if scenario.scenarios?
          await run scenario.scenarios, map
        else
          if ( f = map.get scenario )?
            if scenario.throws?
              ->
                assert.throws ( -> f scenario ), scenario.throws
            else if scenario.rejects?
              ->
                assert.rejects ( -> f scenario ), scenario.rejects
            else
              ->
                result = await f scenario
                Scenario.verify scenario, result

class Runner

  @make: ( scenarios ) -> Object.assign ( new @ ), { scenarios }

  apply: ( runspec ) ->
    map = RunMap.build runspec, @scenarios
    run @scenarios, map

export default Runner