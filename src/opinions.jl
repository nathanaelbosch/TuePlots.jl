
"""
Theme with thinner lines everywhere to suit the typically smaller figure sizes in papers.
"""
MakieThinTheme() = MakieCore.Theme(
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
        # framevisible=false,
        patchsize = (8, 8),
        padding = (5, 5, 5, 5),
    ),
    # Scatter=(strokewidth=0.2, markersize=4),
    # ScatterLines=(linewidth=3, strokewidth=0.5),
)
