# Using TuePlots.jl with Plots.jl

Without TuePlots:

```@example 1
using Plots, TuePlots

data = cumsum(randn(4, 200), dims = 2)

function plot_data(data)
    fig = Figure()
    ax = Axis(fig[1, 1], xlabel = "Time", ylabel = "Quantity of interest")
    sp = series!(ax, data, labels = ["label $i" for i in 1:4])
    axislegend(ax)
    return fig
end

theme(:default;
    TuePlots.get_plotsjl_theme_kwargs(
        TuePlots.SETTINGS[:ICML2022];
        font = true,
        fontsize = true,
        figsize = :full,
    )...)
plot(
    data',
    label = permutedims(["label $i" for i in 1:4]),
    xlabel = "Time",
    ylabel = "Quantity of Interest",
)
```
