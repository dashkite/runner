# Runner Recipes

Task-based scenarios and common patterns for using the Runner.

## Scenario-Based Testing

### Task
Test a component by simulating a series of configuration changes and validating the final request, leveraging the separation of concerns between test logic and test data.

### Runner Approach
Define a component runner to handle the execution logic in CoffeeScript, and use a YAML structure to define the inputs and expected outputs for each test case. Keep the runner logic focused on execution and move verification into the declarative assertions.

### Example
```coffeescript
import Runner from "@dashkite/runner"
# import scenarios from "./scenarios.yaml"

Runner
  .make scenarios
  .apply
    "My Component": 
      "*": ({ input }) ->
        # execution logic goes here
        # return the result to be used by assertions
        result
```

```yaml
- name: My Component
  scenarios:
    - name: Valid Input Scenario
      input:
        key: "value"
      assertions:
        - path: "$.status"
          expect: "success"
        - path: "$.data.id"
          type: "equal"
          expect: 123
```

### Algorithm
1.  Define your scenarios in YAML with descriptive names and input data.
2.  Define assertions in YAML using the `path` and `expect` fields.
3.  Create a `Runner` in CoffeeScript using `Runner.make scenarios`.
4.  Define the execution logic for the scenarios in `apply`.
5.  Execute the runner to run all scenarios and validate the results.

## Generative Testing

### Task
Run a large number of tests for a specific function with varying input data to identify edge cases without writing extensive manual test code.

### Runner Approach
Generate a list of scenarios programmatically and pass them to the `Runner`. This allows for thousands of test cases with minimal extra code. 

### Example
```coffeescript
# generate 1000 test cases goes here
scenarios = generateScenarios()

Runner
  .make scenarios
  .apply
    "*": ({ input }) -> 
        # execution logic goes here
        input * 2
```

### Algorithm
1.  Generate a list of scenario objects programmatically with unique names, input data, and assertions.
2.  Create a `Runner` using `Runner.make scenarios`.
3.  Define the function execution logic in `apply`.
4.  Run the runner to execute all generated test cases.
