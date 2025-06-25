import RunSpec from "./run-spec"
import Query from "./query"

RunMap =

  build: ( runspec, scenarios ) ->
    map = new Map
    for [ path, runner ] in RunSpec.flatten runspec
      runnable = Query
        .build path
        .apply scenarios
      if runnable? && ( runnable.length > 0 )
        for scenario in runnable when scenario.assertions?
          map.set scenario, runner
      else
        console.warn "runner: no scenarios match
          runspec [ #{ path.join ', ' } ]"
    map
      
export default RunMap