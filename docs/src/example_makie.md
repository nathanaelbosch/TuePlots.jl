# Using TuePlots with Makie

Consider series plot of some time series data:

```@example 1
using CairoMakie, TuePlots, Random
CairoMakie.activate!(type = "svg")

data = cumsum(randn(Xoshiro(2), 4, 201), dims = 2)

function plot_data(data; resolution = (487.822, 301.491))
    fig = Figure(resolution = resolution)
    ax = Axis(fig[1, 1], xlabel = "Time", ylabel = "Quantity of interest")
    sp = series!(ax, data, labels = ["label $i" for i in 1:4])
    axislegend(ax)
    return fig
end

plot_data(data)
```

This plot looks fine here in the documentation, but when you imagine it as a full-width plot in a paper, the fonts are much too large.
It's easy to fix these with TuePlots.jl!
All you have to do is create a Makie `Theme` from one of the available settings:

```@example 1
T = Theme(
    TuePlots.SETTINGS[:ICML2022];
    font = true,
    fontsize = true,
    figsize = false,
    thinned = false,
)
```

You can use it as usual:

```@example 1
with_theme(T) do
    plot_data(data)
end
```

Fonts and fontsizes are correct now. Now we can start making the plot more beautiful, e.g. by making lines thinner and reducing the padding. We just create another Theme and merge it with the one from before:

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
        patchsize = (8, 8),
        padding = (5, 5, 5, 5),
    ),
)

with_theme(merge(T, T2)) do
    plot_data(data)
end
```

Voilà!
