function get_plotsjl_theme_kwargs(
    setting::TuePlotsSetting;
    font = false, fontsize = true, figsize = :full, thickness_scaling = true,
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

    if figsize == :full
        resolution = width_to_resolution(setting.width)
        kwargs = merge(kwargs, (; size = resolution))
    elseif figsize == :half
        if !(setting.width_half isa Number)
            raise(ArgumentError("`:half` figsize is not available for this setting."))
        end
        resolution = width_to_resolution(setting.width_half)
        kwargs = merge(kwargs, (; size = resolution))
    end

    if thickness_scaling
        # somehow necessary to get the same font sizes as with Makie.jl
        kwargs = merge(kwargs, (; thickness_scaling = 0.7))
    end

    return kwargs
end
