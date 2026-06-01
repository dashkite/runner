# Runner

*Declarative scenario-based testing for high-value validation.*

Runner simplifies the creation of scenario-based tests by separating test logic from test data. By defining runners as code and scenarios in YAML, developers can easily scale their test suites with generative or manual variations.

For example, testing a request builder is concise when logic and assertions are decoupled:

```coffeescript
import Runner from "@dashkite/runner"

Runner
  .make scenarios
  .apply
    "Request Builder": 
      "*": ({ input }) ->
        builder = $.Request.Builder.make input
        await builder.get()
```

### Features
- **Scenario-Based Testing**: Define tests as declarative data structures.
- **Declarative Assertions**: Use path-based assertions directly in your scenarios.
- **Generative Testing Support**: Easily generate thousands of tests from a single runner.
- **Seamless Integration**: Built on top of `@dashkite/amen` for test execution.

## Installation

Use your favorite package manager to install:

```bash
pnpm add @dashkite/runner
```

## Usage

Define a set of runners and then define your scenarios in YAML, complete with declarative assertions.

```coffeescript
import Runner from "@dashkite/runner"

# Load scenarios from YAML
scenarios = # ... load yaml

Runner
  .make scenarios
  .apply
    "My Runner":
      "*": ({ input }) -> 
        # run logic and return result
        result
```

## Other Resources
- [Reference](./docs/reference.md): Detailed API documentation for the `Runner` class and scenario structure.
- [Recipes](./docs/recipes.md): Common patterns for scenario-based testing.

## Status
This software is currently in active development and is not yet suitable for production use. Please report bugs or request features via the repository's issue tracker.
