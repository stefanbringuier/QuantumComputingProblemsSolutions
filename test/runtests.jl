using Test

"""
execute notebook file using exeception wrapper.
"""
function load(name::String)
    try
        _ = include(name);
        return true
    catch
        return false
    end
end

@testset "notebooks" begin

    @testset "ch1" begin
        @test load("../notebooks/ch1/ch1_pp1.jl")
        @test load("../notebooks/ch1/ch1_pp2.jl")
        @test load("../notebooks/ch1/ch1_pp3.jl")
    end

    @testset "ch2" begin
        @test load("../notebooks/ch2/ch2_pp1.jl")
        @test load("../notebooks/ch2/ch2_pp2.jl")
        @test load("../notebooks/ch2/ch2_pp3.jl")
    end

end