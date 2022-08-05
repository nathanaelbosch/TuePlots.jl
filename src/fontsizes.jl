BASE_FONT_SIZES = Dict(
    :icml2022 => 9,
    :neurips2021 => 10,
    :aistats2022 => 10,
    :jmlr2001 => 10.95,
)

function base_to_theme(base; reduction = 1, small_offset = 2)
    main = base - reduction
    small = main - small_offset
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
FontsizeTheme(key; kwargs...) = base_to_theme(BASE_FONT_SIZES[key]; kwargs...)
