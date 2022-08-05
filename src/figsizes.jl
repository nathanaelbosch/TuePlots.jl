POINTS_PER_INCH = 72.27
GOLDEN_RATIO = (5.0^0.5 - 1.0) / 2.0

# widths in inch
WIDTHS = Dict(
    :icml2022_full => 6.75,
    :icml2022_half => 3.25,
    :aistats2022_full => 6.75,
    :aistats2022_half => 3.25,
    :cvpr2022_full => 496.85625 / POINTS_PER_INCH,
    :cvpr2022_half => 237.13594 / POINTS_PER_INCH,
    :jmlr2001 => 6.0,
    :neurips => 5.5,
)
width_to_resolution(width) =
    (width * POINTS_PER_INCH, width * POINTS_PER_INCH * GOLDEN_RATIO)

"""
Figure sizes for a range of venues, to be used with the `resolution` keyword argument.

# Example
```julia-repl
julia> using CairoMakie, TuePlots

julia> fig = Figure(resolution=TuePlots.FIGSIZES[:icml2022_full])
Scene (488px, 301px):
  0 Plots
  0 Child Scenes
```
"""
FIGSIZES = Dict((k => width_to_resolution(WIDTHS[k]) for k in keys(WIDTHS)))
