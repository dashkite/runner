import * as Amen from "@dashkite/amen"
import RunMap from "./run-map"
import Scenario from "./scenario"

run = ( scenarios, map ) ->
  for scenario in scenarios
    Amen.test scenario.name, 
      if scenario.scenarios?
        await run scenario.scenarios, map
      else
        if ( f = map.get scenario )?
          ->
            Scenario.verify scenario,
              await f scenario

class Runner

  @make: ( scenarios ) -> Object.assign ( new @ ), { scenarios }

  apply: ( runspec ) ->
    map = RunMap.build runspec, @scenarios
    run @scenarios, map


export default Runner