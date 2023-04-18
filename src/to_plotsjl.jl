
"""
    get_plotsjl_theme_kwargs(setting::TuePlotsSetting;
        font = true, fontsize = true, figsize = :full, thinned = trues+

Build a named tuple to be used with `Plots.theme` out of the `TuePlotsSetting`.
"""
function get_plotsjl_theme_kwargs(
    setting::TuePlotsSetting;
    font = false,
    fontsize = true,
    figsize = true,
    single_column = false,
    subplot_height_to_width_ratio = GOLDEN_RATIO,
    nrows = 1, ncols = 1,
    thickness_scaling = true,
)
    kwargs = (;)

    if font
        @error "Fonts are not yet supported for Plots.jl"
        # kwargs = merge(kwargs, (; xlabelfont = "Times New Roman", xlabelfontfamily="serif"))
    end

    if fontsize
        main, small = base_fontsize_to_sizes(setting.base_fontsize)
        kwargs = merge(
            kwargs,
            (
                titlefontsize = main,
                legend_font_pointsize = main,
                legend_title_font_pointsize = main,
                tickfontsize = small,
                labelfontsize = main,
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
        kwargs = merge(kwargs, (; size = resolution))
    end


    if thickness_scaling
        # somehow necessary to get the same font sizes as with Makie.jl
        kwargs = merge(kwargs, (; thickness_scaling = 0.7))
    end

    return kwargs
end
