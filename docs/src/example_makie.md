# Using TuePlots with Makie

!!! info
    This tutorial shows how to set fonts, fontsize, and figure sizes with TuePlots.jl.
    **The resulting plots might not actually look better in the browser! But that's not really a problem: the goal is to make plots for _publications_.**
    Keep this in mind when interpreting the resulting figures.

Let's make a simple series plot of some time series data:

```@example 1
using CairoMakie, TuePlots, Random
CairoMakie.activate!(type = "svg")

data = cumsum(randn(Xoshiro(2), 4, 201), dims = 2)

function plot_data(data)
    fig = Figure(px_per_unit=10,pt_per_unit=10)
    ax = Axis(fig[1, 1], xlabel = "Time", ylabel = "Quantity of interest")
    sp = series!(ax, data, labels = ["label $i" for i in 1:4])
    axislegend(ax)
    return fig
end

plot_data(data)
```

This plot looks fine here in the documentation, but when you imagine it as a full-width plot in a paper the fonts are much too large.
It's easy to fix these with TuePlots.jl!

## Creating and using Makie Themes with TuePlots.jl
All we have to do is create a Makie `Theme` from one of the available settings:

```@example 1
T = Theme(
    TuePlots.SETTINGS[:ICML];
    font = true,
    fontsize = true,
    single_column = false,
    figsize = true,
    thinned = false, # explained later
)
```

We can use `T` like any Makie Theme (see also the [Makie Theming documentation](https://makie.juliaplots.org/stable/documentation/theming/)):

```@example 1
with_theme(T) do
    plot_data(data)
end
```

Fonts and fontsizes are correct now, and the figure size fits perfectly into LaTeX:
You can  directly include it with `\includegraphics{plot.pdf}`, _without even setting some `[width=\linewidth]`_!


## Combining TuePlots.jl's themes with your custom theme

But we're not quite happy with the result yet.
Let's make the plot more beautiful, e.g. by making lines thinner and reducing the padding.
As one would normally do with Makie, we just create another Theme - which we then merge with the previous one:

```@example 1
T2 = Theme(
    figure_padding = 5,
    Axis = (
        spinewidth = 0.5,
        xtickwidth = 0.5,
        ytickwidth = 0.5,
        xticksize = 2,
        yticksize = 2,
    ),
    Legend = (
        framewidth = 0.5,
        patchsize = (20, 8),
        padding = (5, 5, 5, 5),
    ),
)

with_theme(merge(T, T2)) do
    plot_data(data)
end
```

Voilà! And if you like this setting, you can also reduce padding and line widths with less effort by just setting `thinned=true` when creating the Theme.


## Adjust heights to fit simple subplot layouts

In the example above, TuePlots.jl conveniently set the figure size such that the figure nicely fits into the paper.
But the result does not look as nice when we want to have multiple subplots:

```@example 1
data = cumsum(randn(Xoshiro(2), 4, 201), dims = 2)

function simple_subplots(data)
    fig = Figure()
    for i in 1:3
        ax = Axis(fig[1, i])
        sp = series!(ax, data)
    end
    return fig
end

with_theme(T) do
    simple_subplots(data)
end
```

The overall figure size is still the same as above, the width fits the paper and the height is chosen such that the resulting figure has a golden ratio.
But as a result, the individual subplots became too tall.
Instead, we might want to keep the golden ratio of each subplot, and choose the height accordingly.
You can do this by specifying `nrows=1` and `ncols=3` when creating the Makie theme:

```@example 1
T2 = Theme(
    TuePlots.SETTINGS[:ICML];
    font = true,
    fontsize = true,
    figsize = true,
    nrows=1,
    ncols=3,
    thinned = true,
)
with_theme(T2) do
    simple_subplots(data)
end
```

There we go!
This way, each individual subplot has the golden ratio.
