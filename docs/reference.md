# Runner Reference

Detailed API documentation for the Runner class and declarative scenario structure.

## The `Runner` Class

The `Runner` class facilitates the execution of tests based on scenarios and corresponding runner logic.

#### make
$make: scenarios \to Runner$

Creates a new `Runner` instance containing the specified scenarios. Scenarios are typically loaded from a YAML file.

```coffeescript
runner = Runner.make scenarios
```

#### apply
$apply: runspec \dashrightarrow \emptyset$

Maps the scenarios to specific logic defined in the `runspec` and executes the tests. The `runspec` defines how to process each named scenario or group of scenarios.

```coffeescript
await runner.apply
  "Request Builder": 
    "*": ({ input }) ->
      # Process and return result
      result
```

## Scenario Structure

Scenarios define the input data and assertions for your tests.

### Required Fields
- **name**: A unique identifier for the scenario or group of scenarios.
- **scenarios**: (Optional) An array of sub-scenarios.
- **input**: (Optional) The data passed to the runner function.
- **assertions**: (Optional) A list of declarative checks to run against the result.

### Assertions
Assertions consist of:
- **path**: A CoffeeScript expression evaluated against the result (the result is available as `$`).
- **type**: The type of assertion (e.g., `deepEqual`, `equal`, `regexp`).
- **expect**: The value to compare against.

## Technical Notes

### Result Evaluation

When evaluating an assertion path, the result of the runner function is available as the variable `$`. Paths are compiled as bare CoffeeScript and evaluated at runtime.
