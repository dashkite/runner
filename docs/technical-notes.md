# Technical Notes

### Generative Testing Rationale
Scenario-based testing is especially useful to wrangle generative tests, which might require extensive code to test if written directly. By separating logic from data, scenarios can be programmatically generated as data and passed to the runner, allowing for thousands of test cases with minimal extra code.

### Result Access in Assertions
Within an assertion `path`, the result returned by the runner function is available as the variable `$`. Paths are compiled as bare CoffeeScript and evaluated at runtime.

### Error Handling
If a scenario includes `throws` or `rejects` properties, the runner automatically wraps the execution in the appropriate assertion check.

### Best Practices
- **Use Subgroups**: Organize scenarios into logical groups for better test reporting.
- **Generative Generation**: For complex logic, write a script to generate the `scenarios` array instead of manually editing YAML.
- **Minimal Logic**: Keep the runner logic focused on execution; move verification and data checks into the declarative assertions.
- **Refer to Skills**: Combine with the `writing-tests` skill for overall test architecture.
