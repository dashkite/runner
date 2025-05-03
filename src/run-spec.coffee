RunSpec =

  flatten: ( runspec, path = []) ->
    result = []
    for key, value of runspec
      if value.apply?
        result.push [[ path..., key ], value ]
      else
        result = [
          result...
          ( RunSpec.flatten value, [ path..., key ])...
        ]
    result

export default RunSpec