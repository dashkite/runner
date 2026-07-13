import { test, success } from "@dashkite/amen"
import print from "@dashkite/amen-console"

import queryTests from "./query"
import runSpecTests from "./run-spec"
import scenarioTests from "./scenario"

do ->
  print await test "DashKite Runner", [
    queryTests
    runSpecTests
    scenarioTests
  ]

  process.exit if success then 0 else 1
