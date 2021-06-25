using BISC195Labs
using Combinatorics
using Test

@testset "Lab03" begin
    bases = collect("ATGC")

    # Test match score
    for base in bases
        @test nwscore(base, base) == 1
        @test nwscore(base, base; match = 2) == 2
    end

    # Test mismatch score
    for (b1, b2) in combinations(bases, 2)
        @test nwscore(b1, b2) == -1
        @test nwscore(b1, b2; mismatch = -2) == -2
    end
    
    # Test gap score
    for (base) in bases
        @test nwscore(base, nothing) == -1
        @test nwscore(nothing, base) == -1
        @test nwscore(base, nothing; gap = -2) == -2
        @test nwscore(nothing, base; gap = -2) == -2
    end

    #Test Double gap score
    for (base) in bases
        @test_throws ArgumentError nwscore(nothing, nothing)
    end

    #NWalign test
    for (base) in bases
        @test nwalign(base1, base2) == "base1, base2"
        @test nwalign(base2, base1) == "base2, base1"
        @test nwalign(base1, nothing) == "base1, nothing"
        @test nwalign(nothing, base1) == "nothing, base1"
end
