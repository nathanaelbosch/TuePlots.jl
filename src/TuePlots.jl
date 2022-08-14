module TuePlots

using MakieCore

const POINTS_PER_INCH = 72.27
const GOLDEN_RATIO = (5.0^0.5 - 1.0) / 2.0
width_to_resolution(width) =
    (width * POINTS_PER_INCH, width * POINTS_PER_INCH * GOLDEN_RATIO)

const FONTSIZE_REDUCTION = 1
const SMALL_FONTSIZE_OFFSET = 2
base_fontsize_to_sizes(base; reduction = 1, small_offset = 2) =
    (base - FONTSIZE_REDUCTION, base - FONTSIZE_REDUCTION - SMALL_FONTSIZE_OFFSET)

include("settings.jl")
include("to_makie.jl")
include("to_plotsjl.jl")

include("opinions.jl")

end
