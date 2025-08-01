import RunSpec from "./run-spec"
import Query from "./query"

isRunnable = ( scenario ) ->
  scenario.assertions? || 
    scenario.throws? ||
    scenario.rejects?

RunMap =

  build: ( runspec, scenarios ) ->
    map = new Map
    for [ path, runner ] in RunSpec.flatten runspec
      runnable = Query
        .build path
        .apply scenarios
      if runnable? && ( runnable.length > 0 )
        for scenario in runnable when isRunnable scenario
          map.set scenario, runner
    map
      
export default RunMap