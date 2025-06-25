import * as Amen from "@dashkite/amen"
import RunMap from "./run-map"
import Scenario from "./scenario"

debug = ( process.env.debug? || process.env.DEBUG? )

run = ( scenarios, map ) ->
  for scenario in scenarios
    await do ( scenario ) ->
      Amen.test scenario.name, 
        if scenario.scenarios?
          await run scenario.scenarios, map
        else
          if ( f = map.get scenario )?
            ->
              result = await f scenario
              Scenario.verify scenario, result

class Runner

  @make: ( scenarios ) -> Object.assign ( new @ ), { scenarios }

  apply: ( runspec ) ->
    map = RunMap.build runspec, @scenarios
    run @scenarios, map

export default Runner