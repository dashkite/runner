import { test } from "@dashkite/amen"
import assert from "@dashkite/assert"
import RunSpec from "../src/run-spec"

export default test "RunSpec", [
  test "flatten", ->
    fn1 = ->
    fn2 = ->
    spec =
      A:
        B: fn1
        C: fn2
    result = RunSpec.flatten spec
    assert.equal result.length, 2
    assert.deepEqual result[0][0], ["A", "B"]
    assert.equal result[0][1], fn1
    assert.deepEqual result[1][0], ["A", "C"]
    assert.equal result[1][1], fn2
]
