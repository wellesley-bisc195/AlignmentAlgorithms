using Base: String
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

    # Test error thrown by double gap
    for (b1, b2) in combinations(bases, 2)
        @test_throws ArgumentError nwscore(nothing, nothing)
        @test_throws ArgumentError nwscore(nothing, nothing; match = 2, mismatch = -1, gap = -3)
        @test_throws ArgumentError nwscore(nothing, nothing; mismatch = -4, gap = -3)
        @test_throws ArgumentError nwscore(nothing, nothing; match = 1, gap = 0)
    end

    # Test nwaligner()
    sampleString = "AGCTGTGA"
    sampleString2 = "ACTGTGG"
    @test nwaligner(sampleString, sampleString2) isa Array
    @test_throws ArgumentError nwaligner(nothing, nothing)
    @test nwaligner(sampleString, sampleString2) == [['A', 'G', 'C', 'T', 'G', 'T', 'G', 'A'], ['A', '-', 'C', 'T', 'G', 'T', 'G', 'G']] 
end
