import { test } from "@dashkite/amen"
import assert from "@dashkite/assert"
import Scenario from "../src/scenario"

export default test "Scenario", [
  test "truthy verification", ->
    scenario = 
      assertions: [
        path: "$ == 'foo'"
      ]
    Scenario.verify scenario, "foo"
    
  test "typed verification (equal)", ->
    scenario = 
      assertions: [
        path: "$.status"
        type: "equal"
        expect: 200
      ]
    Scenario.verify scenario, status: 200

  test "typed verification (regexp)", ->
    scenario =
      assertions: [
        path: "new RegExp('hello')"
        type: "regexp"
        expect: "/hello/"
      ]
    Scenario.verify scenario, null

  test "failed verification throws", ->
    scenario =
      assertions: [
        path: "$.status"
        type: "equal"
        expect: 200
      ]
    try
      Scenario.verify scenario, status: 500
      assert false
    catch e
      assert e.message.includes "assertion failed"
]
