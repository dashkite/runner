# Runner Recipes

Task-based scenarios and common patterns for using the Runner.

## Scenario-Based Testing

### Task
Test a request builder by simulating a series of configuration changes and validating the final request.

### Runner Approach
Define a `Request Builder` runner to handle the logic and scenarios in YAML for the data and assertions.

### Example
```coffeescript
import Runner from "@dashkite/runner"

Runner
  .make scenarios
  .apply
    "Request Builder": 
      "*": ({ input }) ->
        builder = $.Request.Builder.make input
        await builder.get()
        builder
          .update ( input ) ->
            input.headers.authorization = "foo 123"
            input
        request = await builder.get()
        request
```

```yaml
- name: Request Builder
  scenarios:
    - name: Update headers after initial get
      input:
        url: "https://foobar.com/hello?name=world"
      assertions:
        - path: ( $.headers.get "authorization" )
          type: deepEqual
          expect: 
            scheme: foo
            token: "123"
```

### Algorithm
1.  Define your scenarios in YAML with descriptive names and input data.
2.  Define assertions in YAML using the `path` and `expect` fields.
3.  Create a `Runner` in CoffeeScript using `Runner.make scenarios`.
4.  Define the execution logic for the scenarios in `apply`.
5.  Execute the runner to run all scenarios and validate the results.

## Generative Testing

### Task
Run a large number of tests for a specific function with varying input data to identify edge cases.

### Runner Approach
Generate a list of scenarios programmatically and pass them to the `Runner`.

### Example
```coffeescript
# Generate 1000 test cases
scenarios = for i in [ 1..1000 ]
  name: "Generated Test #{i}"
  input: i
  assertions: [
    path: "$ * 2"
    expect: i * 2
  ]

Runner
  .make scenarios
  .apply
    "*": ({ input }) -> input * 2
```

### Algorithm
1.  Generate a list of scenario objects with unique names, input data, and assertions.
2.  Create a `Runner` using `Runner.make scenarios`.
3.  Define the function logic in `apply`.
4.  Run the runner to execute all generated test cases.
