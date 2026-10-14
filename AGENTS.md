# AGENTS.md

## Formatting

CI checks formatting with JuliaFormatter (`.github/workflows/FormatCheck.yml`, settings in `.JuliaFormatter.toml`).
Format before committing:

```sh
julia --project=@JuliaFormatter -e 'using Pkg; Pkg.add("JuliaFormatter"); Pkg.update(); using JuliaFormatter; format(["src", "test", "docs"])'
```
