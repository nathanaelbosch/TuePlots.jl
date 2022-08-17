using TuePlots
using Documenter

DocMeta.setdocmeta!(TuePlots, :DocTestSetup, :(using TuePlots); recursive = true)

makedocs(;
    modules = [TuePlots],
    authors = "Nathanael Bosch <nathanael.bosch@uni-tuebingen.de> and contributors",
    repo = "https://github.com/nathanaelbosch/TuePlots.jl/blob/{commit}{path}#{line}",
    sitename = "TuePlots.jl",
    format = Documenter.HTML(;
        prettyurls = get(ENV, "CI", "false") == "true",
        canonical = "https://nathanaelbosch.github.io/TuePlots.jl",
        edit_link = "main",
        assets = String[],
    ),
    pages = [
        "Home" => "index.md",
        "Example with Makie (recommended)" => "example_makie.md",
        "Example with Plots.jl (experimental)" => "example_plotsjl.md",
        "API" => "api.md",
    ],
)

deploydocs(;
    repo = "github.com/nathanaelbosch/TuePlots.jl",
    devbranch = "main",
    push_preview = true,
)
