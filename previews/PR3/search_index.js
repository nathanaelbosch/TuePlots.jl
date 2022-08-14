var documenterSearchIndex = {"docs":
[{"location":"example_makie/#Using-TuePlots.jl-with-Makie.jl","page":"Example with Makie.jl","title":"Using TuePlots.jl with Makie.jl","text":"","category":"section"},{"location":"example_makie/","page":"Example with Makie.jl","title":"Example with Makie.jl","text":"Consider series plot of some time series data:","category":"page"},{"location":"example_makie/","page":"Example with Makie.jl","title":"Example with Makie.jl","text":"using CairoMakie, TuePlots\nCairoMakie.activate!(type = \"svg\")\n\ndata = cumsum(randn(4, 200), dims = 2)\n\nfunction plot_data(data; resolution = (487.822, 301.491))\n    fig = Figure(resolution = resolution)\n    ax = Axis(fig[1, 1], xlabel = \"Time\", ylabel = \"Quantity of interest\")\n    sp = series!(ax, data, labels = [\"label $i\" for i in 1:4])\n    axislegend(ax)\n    return fig\nend\n\nplot_data(data)","category":"page"},{"location":"example_makie/","page":"Example with Makie.jl","title":"Example with Makie.jl","text":"This plot looks fine here in the documentation, but when you imagine it as a full-width plot in a paper, the fonts are much too large. It's easy to fix these with TuePlots.jl! All you have to do is create a Makie Theme from one of the available settings:","category":"page"},{"location":"example_makie/","page":"Example with Makie.jl","title":"Example with Makie.jl","text":"T = Theme(\n    TuePlots.SETTINGS[:ICML2022];\n    font = true,\n    fontsize = true,\n    figsize = false,\n    thinned = false,\n)","category":"page"},{"location":"example_makie/","page":"Example with Makie.jl","title":"Example with Makie.jl","text":"You can use it as usual:","category":"page"},{"location":"example_makie/","page":"Example with Makie.jl","title":"Example with Makie.jl","text":"with_theme(T) do\n    plot_data(data)\nend","category":"page"},{"location":"example_makie/","page":"Example with Makie.jl","title":"Example with Makie.jl","text":"Fonts and fontsizes are correct now. Now we can start making the plot more beautiful, e.g. by making lines thinner and reducing the padding. We just create another Theme and merge it with the one from before:","category":"page"},{"location":"example_makie/","page":"Example with Makie.jl","title":"Example with Makie.jl","text":"T2 = Theme(\n    figure_padding = 5,\n    Axis = (\n        spinewidth = 0.5,\n        xtickwidth = 0.5,\n        ytickwidth = 0.5,\n        xticksize = 2,\n        yticksize = 2,\n    ),\n    Legend = (\n        framewidth = 0.5,\n        patchsize = (8, 8),\n        padding = (5, 5, 5, 5),\n    ),\n)\n\nwith_theme(merge(T, T2)) do\n    plot_data(data)\nend","category":"page"},{"location":"example_makie/","page":"Example with Makie.jl","title":"Example with Makie.jl","text":"Voilà!","category":"page"},{"location":"example_plotsjl/#Using-TuePlots.jl-with-Plots.jl","page":"Example with Plots.jl","title":"Using TuePlots.jl with Plots.jl","text":"","category":"section"},{"location":"example_plotsjl/","page":"Example with Plots.jl","title":"Example with Plots.jl","text":"Without TuePlots:","category":"page"},{"location":"example_plotsjl/","page":"Example with Plots.jl","title":"Example with Plots.jl","text":"using Plots, TuePlots\n\ndata = cumsum(randn(4, 200), dims = 2)\n\nfunction plot_data(data)\n    fig = Figure()\n    ax = Axis(fig[1, 1], xlabel = \"Time\", ylabel = \"Quantity of interest\")\n    sp = series!(ax, data, labels = [\"label $i\" for i in 1:4])\n    axislegend(ax)\n    return fig\nend\n\ntheme(:default;\n    TuePlots.get_plotsjl_theme_kwargs(\n        TuePlots.SETTINGS[:ICML2022];\n        font = true,\n        fontsize = true,\n        figsize = :full,\n        thinned = true,\n    )...)\nplot(\n    data',\n    label = permutedims([\"label $i\" for i in 1:4]),\n    xlabel = \"Time\",\n    ylabel = \"Quantity of Interest\",\n)","category":"page"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = TuePlots","category":"page"},{"location":"#TuePlots","page":"Home","title":"TuePlots","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for TuePlots.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [TuePlots]","category":"page"},{"location":"#TuePlots.MakieThinTheme","page":"Home","title":"TuePlots.MakieThinTheme","text":"Theme with thinner lines everywhere to suit the typically smaller figure sizes in papers.\n\n\n\n\n\n","category":"constant"}]
}
