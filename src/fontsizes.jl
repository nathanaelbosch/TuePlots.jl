BASE_FONT_SIZES = Dict(
    :icml2022 => 9,
    :neurips2021 => 10,
    :aistats2022 => 10,
    :jmlr2001 => 10.95,
)

base_to_sizes(base; reduction = 1, small_offset = 2) =
    (base - reduction, base - reduction - small_offset)
function base_to_theme(base; reduction = 1, small_offset = 2)
    main, small = base_to_sizes(base; reduction = reduction, small_offset = small_offset)
    t = MakieCore.Theme(
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
    )
    return t
end
MakieFontsizeTheme(key; kwargs...) = base_to_theme(BASE_FONT_SIZES[key]; kwargs...)

function plotsjl_fontsize_theme_kwargs(key; kwargs...)
    main, small = base_to_sizes(BASE_FONT_SIZES[key]; kwargs...)
    return (
        titlefontsize = main,
        legend_font_pointsize = small,
        legend_title_font_pointsize = main,
        tickfontsize = small,
        labelfontsize = main,
    )
end
