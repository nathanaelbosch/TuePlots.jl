function MakieCore.Theme(
    setting::TuePlotsSetting;
    font=true, fontsize=true, figsize=:full, thinned=true,
    )

    theme = MakieCore.Theme()

    if font
        theme = merge(theme, MakieCore.Theme(font=setting.font))
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

    if figsize == :full
        resolution = width_to_resolution(setting.width)
        theme = merge(theme, MakieCore.Theme(resolution = resolution))
    elseif figsize == :half && setting.width_half isa Number
        resolution = width_to_resolution(setting.width_half)
        theme = merge(theme, MakieCore.Theme(resolution = resolution))
    end

    if thinned
        theme = merge(theme, MakieThinTheme)
    end

    return theme
end
