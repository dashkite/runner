# Runner Reference

Detailed API documentation for the Runner class and declarative scenario structure.

## Runner

The `Runner` class facilitates the execution of tests based on scenarios and corresponding runner logic.

### make
$make: scenarios \to runner$

Creates a new `Runner` instance containing the specified scenarios. Scenarios are typically loaded from a YAML file.

```coffeescript
runner = Runner.make scenarios
```

### apply
$apply: runspec \dashrightarrow \emptyset$

Maps the scenarios to specific logic defined in the `runspec` and executes the tests. The `runspec` defines how to process each named scenario or group of scenarios.

```coffeescript
await runner.apply
  "My Component": 
    "*": ({ input }) ->
      result
```

## Scenario

Scenarios define the input data and assertions for your tests.

### name
A unique identifier for the scenario or group of scenarios.

### scenarios
An array of sub-scenarios. Use subgroups to organize scenarios into logical groups for better test reporting.

### input
The data passed to the runner function.

### assertions
A list of declarative checks to run against the result.

### throws
If a scenario includes a `throws` property, the runner automatically wraps the execution in the appropriate assertion check for synchronous errors.

### rejects
If a scenario includes a `rejects` property, the runner automatically wraps the execution in the appropriate assertion check for asynchronous errors.

## Assertion

Assertions consist of several fields to declare expected results.

### path
A CoffeeScript expression evaluated against the result. The result of the runner function is available as the variable `$`.

### type
The type of assertion (e.g., `deepEqual`, `equal`, `regexp`). Defaults to a truthy check if omitted.

### expect
The value to compare against.
