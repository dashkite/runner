import RunSpec from "./run-spec"
import Query from "./query"

RunMap =

  build: ( runspec, scenarios ) ->
    map = new Map
    for [ path, runner ] in RunSpec.flatten runspec
      runnable = Query
        .build path
        .apply scenarios
      for scenario in runnable
        map.set scenario, runner
    map
      
export default RunMap