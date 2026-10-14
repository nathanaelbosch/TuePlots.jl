"""
    Makie.Theme(setting::TuePlotsSetting;
        font = true, fontsize = true, figsize = true, thinned = true, ...)

Make a Makie `Theme` out of the `TuePlotsSetting`.

`font` can be `true` to use the font of the setting, `false` to keep Makie's fonts, or the
name of a font family, e.g. `font = "TeX Gyre Termes"`.
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

    if font != false
        theme = merge(
            Makie.Theme(
                fonts = makie_fonts(font === true ? setting.font : font),
                Axis = (; titlefont = :regular),
                Axis3 = (; titlefont = :regular),
                Legend = (; titlefont = :regular),
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

function makie_fonts(family)
    if family == "TeX Computer Modern"
        return (;
            regular = Makie.texfont(:regular),
            bold = Makie.texfont(:bold),
            italic = Makie.texfont(:italic),
            bold_italic = Makie.texfont(:bolditalic),
        )
    end
    candidates = font_alternatives(family)
    i = findfirst(is_font_available, candidates)
    if isnothing(i)
        @warn "Could not find any of the fonts $(join(candidates, ", ")); using TeX Computer Modern instead."
        return makie_fonts("TeX Computer Modern")
    end
    family = candidates[i]
    return (;
        regular = family,
        bold = "$family Bold",
        italic = "$family Italic",
        bold_italic = "$family Bold Italic",
    )
end

font_alternatives(family) =
    if family in ("Times", "Times New Roman")
        unique([family, "Times New Roman", "Times", "TeX Gyre Termes", "Nimbus Roman"])
    else
        [family]
    end

function is_font_available(family)
    font = Makie.FreeTypeAbstraction.findfont(family; additional_fonts = Makie.assetpath("fonts"))
    return !isnothing(font) && startswith(lowercase(font.family_name), lowercase(family))
end
