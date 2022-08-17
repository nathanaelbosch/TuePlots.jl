# TuePlots.jl

A Julia port of the [tueplots](https://github.com/pnkraemer/tueplots/) Python package.

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://nathanaelbosch.github.io/TuePlots.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://nathanaelbosch.github.io/TuePlots.jl/dev/)
[![Build Status](https://github.com/nathanaelbosch/TuePlots.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/nathanaelbosch/TuePlots.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/nathanaelbosch/TuePlots.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/nathanaelbosch/TuePlots.jl)

TuePlots helps you create better plots for scientific publications.
TuePlots does _not_ try to make your plots "beautiful" - colors and line widths are up to you - but it takes care of the annoying bits like figure size, font size, and setting the correct font.
Look at the following example:

<img src="files/paper_before.svg" width="400"/> <img src="files/paper_after.svg" width="400"/>

The figure on the left is created with the CairoMakie default settings.
Since the figure resolution does not fit the PDF page, it has to be rescaled in LaTeX and as a result font sizes are completely off.
But with just a few lines of TuePlots.jl you get the result on the right, with correct fonts and figure sizes - you don't even need to do `[width=\linewidth]` in LaTeX anymore!

## Installation

Install TuePlots directly with the Julia package manager:

```
julia> ]
(v1.7) pkg> add TuePlots
```

## TuePlots.jl with CairoMakie.jl (recommended)

Using TuePlots with (Cairo)Makie is easy: Just create a `Makie.Theme` from one of the settings provided by TuePlots:

```julia
using CairoMakie, TuePlots, Random

data = cumsum(randn(Xoshiro(2), 4, 201), dims = 2)

# Create a Makie.Theme with correct font, fontsize, and figure size:
T = Theme(TuePlots.SETTINGS[:AISTATS2022];
          font = true, fontsize = true, figsize = :half, thinned = true)

with_theme(T) do
    fig = Figure()
    ax = Axis(fig[1, 1], xlabel = "Time", ylabel = "Quantity of interest")
    sp = series!(ax, data, labels = ["label $i" for i in 1:4])
    axislegend(ax)
    save("makie.pdf", fig, pt_per_unit = 1) # pt_per_unit is needed to ensure the correct sizes
end
```

<p align="center">
<img src="./files/makie.svg" width="400" />
</p>

Voilà! Now you can focus on the important things, like choosing the best color scheme for your plot.

## TuePlots.jl with Plots.jl (experimental)

**WARNING:** This is still experimental and some features do not yet work correctly! For the best experience, use TuePlots with (Cairo)Makie.

To use TuePlots.jl with Plots.jl, you can let TuePlots generate keyword arguments for `Plots.theme` as follows:

```julia
using Plots, TuePlots, Random

data = cumsum(randn(Xoshiro(2), 4, 201), dims = 2)

theme(:default;
    TuePlots.get_plotsjl_theme_kwargs(
        TuePlots.SETTINGS[:AISTATS2022];
        fontsize = true,
        figsize = :half,
    )...)

plot(data',
    label = permutedims(["label $i" for i in 1:4]),
    xlabel = "Time",
    ylabel = "Quantity of interest",
);
savefig("plotsjl.pdf")
```

<p align="center">
<img src="./files/plotsjl.svg" width="400" />
</p>
