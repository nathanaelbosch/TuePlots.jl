"""
    MakieCore.Theme(setting::TuePlotsSetting;
        font = true, fontsize = true, figsize = :full, thinned = true

Make a Makie `Theme` out of the `TuePlotsSetting`.
"""
function MakieCore.Theme(
    setting::TuePlotsSetting;
    font = true,
    fontsize = true,
    figsize = true,
    single_column = false,
    subplot_height_to_width_ratio = GOLDEN_RATIO,
    nrows = 1, ncols = 1,
    thinned = true,
)
    theme = MakieCore.Theme()

    if font
        theme = merge(theme, MakieCore.Theme(font = setting.font))
    end

    if fontsize
        main, small = base_fontsize_to_sizes(setting.base_fontsize)
        theme = merge(
            theme,
            MakieCore.Theme(
                fontsize = main,
                Axis = (
                    xticklabelsize = small,
                    yticklabelsize = small,
                    xlabelsize = main,
                    ylabelsize = main,
                    titlesize = main,
                ),
                Legend = (
                    labelsize = main,
                ),
                Colorbar = (
                    labelsize = main,
                    ticklabelsize = small,
                ),
            ),
        )
    end

    if figsize
        width = if !single_column
            setting.width
        else
            if !setting.width_half isa Number
                error("`single_column` not supported for this setting")
            end
            setting.width_half
        end
        height = width * subplot_height_to_width_ratio * nrows / ncols
        resolution = (width * POINTS_PER_INCH, height * POINTS_PER_INCH)
        theme = merge(theme, MakieCore.Theme(resolution = resolution))
    end

    if thinned
        theme = merge(theme, MakieThinTheme)
    end

    return theme
end
