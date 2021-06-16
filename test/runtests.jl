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

    # Test with kwargs
    for (base) in bases
        @test nwscore(base, base, gap = -1) == 1
        @test nwscore(base, nothing, match = 2) == -1
        @test nwscore(nothing, base, mismatch = -2) == -1
    end

    # Test double gap
    @test_throws ArgumentError nwscore(nothing, nothing)
    @test_throws ArgumentError nwscore(nothing, nothing, match = 2, mismatch = -3)
    @test_throws ArgumentError nwscore(nothing, nothing, gap = -2)

    # Test nwalign()
    seq1 = "ATGC"
    seq2 = "TAGC"
    @test nwalign(seq1, seq1) == 4
    @test nwalign(seq1, seq2) == 0
end
