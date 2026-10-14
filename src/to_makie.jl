"""
    Makie.Theme(setting::TuePlotsSetting;
        font = true, fontsize = true, figsize = :full, thinned = true

Make a Makie `Theme` out of the `TuePlotsSetting`.
"""
function Makie.Theme(
    setting::TuePlotsSetting;
    font = true,
    fontsize = true,
    figsize = true,
    single_column = false,
    height_ratio = GOLDEN_RATIO,
    width_coeff = 1,
    thinned = true,
)
    theme = Makie.Theme(CairoMakie = (; pt_per_unit = 1))

    if font
        theme = merge(
            Makie.Theme(
                font = setting.font,
                Axis = (
                    titlefont = setting.font,
                    subtitlefont = setting.font,
                    xlabelfont = setting.font,
                    ylabelfont = setting.font,
                    xticklabelfont = setting.font,
                    yticklabelfont = setting.font,
                ),
                Axis3 = (
                    titlefont = setting.font,
                    xlabelfont = setting.font,
                    ylabelfont = setting.font,
                    zlabelfont = setting.font,
                    xticklabelfont = setting.font,
                    yticklabelfont = setting.font,
                    zticklabelfont = setting.font,
                ),
                Legend = (
                    titlefont = setting.font,
                    labelfont = setting.font,
                ),
                Colorbar = (
                    labelfont = setting.font,
                    ticklabelfont = setting.font,
                ),
                Label = (
                    font = setting.font,
                ),
            ),
            theme,
        )
    end

    if fontsize
        main, small = base_fontsize_to_sizes(setting.base_fontsize)
        theme = merge(
            Makie.Theme(
                fontsize = main,
                Axis = (
                    titlesize = main,
                    subtitlesize = main,
                    xticklabelsize = small,
                    yticklabelsize = small,
                    xlabelsize = main,
                    ylabelsize = main,
                ),
                Axis3 = (
                    titlesize = main,
                    subtitlesize = main,
                    xticklabelsize = small,
                    yticklabelsize = small,
                    zticklabelsize = small,
                    xlabelsize = main,
                    ylabelsize = main,
                    zlabelsize = main,
                ),
                Legend = (;
                    labelsize = main,
                ),
                Colorbar = (
                    labelsize = main,
                    ticklabelsize = small,
                ),
                Label = (;
                    fontsize = small
                ),
            ),
            theme,
        )
    end

    if figsize
        width = if !single_column
            setting.width
        else
            if !(setting.width_half isa Number)
                error("`single_column` not supported for this setting")
            end
            setting.width_half
        end
        width *= width_coeff
        height = width * height_ratio
        size = (width * POINTS_PER_INCH, height * POINTS_PER_INCH)
        theme = merge(Makie.Theme(size = size), theme)
    end

    if thinned
        theme = merge(MakieThinTheme, theme)
    end

    return theme
end
