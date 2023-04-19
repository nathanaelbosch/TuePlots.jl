module TuePlots

using MakieCore

const POINTS_PER_INCH = 72.27
const GOLDEN_RATIO = (5.0^0.5 - 1.0) / 2.0

const FONTSIZE_REDUCTION = 1
const SMALL_FONTSIZE_OFFSET = 2
base_fontsize_to_sizes(base) =
    (base - FONTSIZE_REDUCTION, base - FONTSIZE_REDUCTION - SMALL_FONTSIZE_OFFSET)

include("settings.jl")

include("to_makie.jl")
include("to_plotsjl.jl")

include("opinions.jl")

end
