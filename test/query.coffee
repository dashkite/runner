import { test } from "@dashkite/amen"
import assert from "@dashkite/assert"
import Query from "../src/query"

scenarios = [
  name: "A"
  scenarios: [
    name: "A.1"
  ]
,
  name: "B"
  scenarios: [
    name: "B.1"
    scenarios: [
      name: "B.1.x"
    ]
  ]
]

export default test "Query", [
  test "matching", ->
    matcher = Query.matching "A"
    result = matcher scenarios
    assert.deepEqual result, [ name: "A.1" ]

  test "children", ->
    result = Query.children scenarios[1].scenarios
    assert.deepEqual result, []
    
    result2 = Query.children [ { name: "Leaf1" }, { name: "Leaf2", scenarios: [] } ]
    assert.equal result2.length, 1
    assert.equal result2[0].name, "Leaf1"

  test "descendents", ->
    result = Query.descendents scenarios
    assert.equal result.length, 2
    assert.equal result[0].name, "A.1"
    assert.equal result[1].name, "B.1.x"

  test "build and apply", ->
    query = Query.build ["B", "**"]
    result = query.apply scenarios
    assert.equal result.length, 1
    assert.equal result[0].name, "B.1.x"
]
