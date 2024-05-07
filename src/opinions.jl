"""
Makie theme with thinner lines everywhere.

Helpful to improve most Makie plots, since the default settings are often chosen
for much larger plots than the small figure sizes used in papers.
"""
const MakieThinTheme = MakieCore.Theme(
    figure_padding = 5,
    Axis = (
        spinewidth = 0.5,
        xgridwidth = 0.5,
        ygridwidth = 0.5,
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
    Colorbar = (;
        spinewidth = 0.5
    ),
)
