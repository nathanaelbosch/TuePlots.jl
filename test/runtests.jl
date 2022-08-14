using TuePlots
using Test, SafeTestsets, Aqua
import MakieCore, Plots

@testset "TuePlots.jl" begin
    setting_keys = TuePlots.get_available_settings()

    @testset "Makie themes" begin
        @testset "$k" for k in setting_keys
            s = TuePlots.SETTINGS[k]
            @test MakieCore.Theme(s) isa MakieCore.Theme
        end
    end

    @testset "Plots.jl themes" begin
        @testset "$k" for k in setting_keys
            s = TuePlots.SETTINGS[k]
            @test Plots.theme(:default; TuePlots.get_plotsjl_theme_kwargs(s)...) |>
                  isnothing
        end
    end
end
