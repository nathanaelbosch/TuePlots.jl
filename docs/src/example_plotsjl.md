# Using TuePlots with Plots.jl (experimental)

**WARNING:** This is still experimental and some features do not yet work correctly! For the best experience, use TuePlots with (Cairo)Makie
(see "[Using TuePlots with Makie](@ref)").

```@example 1
using Plots, TuePlots, Random

data = cumsum(randn(Xoshiro(2), 4, 201), dims = 2)

function plot_data(data)
    fig = Figure()
    ax = Axis(fig[1, 1], xlabel = "Time", ylabel = "Quantity of interest")
    sp = series!(ax, data, labels = ["label $i" for i in 1:4])
    axislegend(ax)
    return fig
end

theme(:default;
    TuePlots.get_plotsjl_theme_kwargs(
        TuePlots.SETTINGS[:ICML];
        font = true,
        fontsize = true,
        figsize = true,
    )...)
plot(
    data',
    label = permutedims(["label $i" for i in 1:4]),
    xlabel = "Time",
    ylabel = "Quantity of Interest",
)
```
