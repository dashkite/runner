# @dashkite/runner

*Declarative scenario-based testing for high-value validation.*

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

Runner simplifies the creation of scenario-based tests by separating test logic from test data. By defining runners as code and scenarios in YAML, creators can scale their test suites with generative or manual variations.

## Features

- Define tests as declarative data structures.
- Use path-based assertions directly in your scenarios.
- Generate tests programmatically from a single runner.
- Execute tests through `@dashkite/amen` integration.

## Installation

```bash
pnpm install @dashkite/runner
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

- [Reference](docs/reference.md): Detailed API documentation for the Runner class and scenario structure.
- [Recipes](docs/recipes.md): Common patterns for scenario-based testing.
- [Technical Notes](docs/technical-notes.md): Implementation details and architectural context.
- [Testing](docs/testing.md): Testing guidelines for the project.
