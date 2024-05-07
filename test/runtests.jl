using TuePlots
using Test, SafeTestsets, Aqua
import MakieCore, Plots

using CairoMakie

function makie_plot(s)
    with_theme(MakieCore.Theme(s)) do
        lines(1:4, 1:4)
    end

    current_figure()
end

@testset "TuePlots.jl" begin
    setting_keys = TuePlots.get_available_settings()

    @testset "Makie themes" begin
        @testset "$k" for k in setting_keys
            s = TuePlots.SETTINGS[k]
            @test MakieCore.Theme(s) isa MakieCore.Theme
            if s.width_half isa Number
                @test_nowarn MakieCore.Theme(s; single_column = true)
            else
                @test_throws ErrorException MakieCore.Theme(s; single_column = true)
            end

            @test makie_plot(s) isa Makie.Figure
        end
    end

    @testset "Plots.jl themes" begin
        @testset "$k" for k in setting_keys
            s = TuePlots.SETTINGS[k]
            @test Plots.theme(:default; TuePlots.get_plotsjl_theme_kwargs(s)...) |>
                  isnothing
        end
    end

    @testset "Aqua.jl" begin
        Aqua.test_all(TuePlots, ambiguities = false)
        Aqua.test_ambiguities(TuePlots)
    end
end
