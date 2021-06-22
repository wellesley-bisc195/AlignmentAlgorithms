using BISC195Labs
using Combinatorics
using Test

@testset "Lab03" begin
    bases = collect("ATGC")

    # Test match score
    for base in bases
        @test nwscore(base, base) == 1
        @test nwscore(base, base; match = 2) == 2
        @test nwscore(base, base; match = 1, gap = -2) == 1
    end

    # Test mismatch score
    for (b1, b2) in combinations(bases, 2)
        @test nwscore(b1, b2) == -1
        @test nwscore(b1, b2; mismatch = -2) == -2
        @test nwscore(b1, b2; mismatch = -1, gap = -2) == -1
    end
    
    # Test gap score
    for (base) in bases
        @test nwscore(base, nothing) == -1
        @test nwscore(nothing, base) == -1
        @test nwscore(base, nothing; gap = -2) == -2
        @test nwscore(nothing, base; gap = -2) == -2
        @test nwscore(base, nothing; match = 2, gap = -2) == -2
        @test nwscore(nothing, base; mismatch = -1, gap = -2) == -2
        @test nwscore(base, nothing; match = 2, mismatch = -1, gap = -2) == -2
        @test nwscore(nothing, base; match = 2, mismatch = -1, gap = -2) == -2
    end

    # Test error
    @test_throws ArgumentError nwscore(nothing, nothing)
    @test_throws ArgumentError nwscore(nothing, nothing; gap = -2)
    @test_throws ArgumentError nwscore(nothing, nothing; match = 2, mismatch = -3)
    @test_throws ArgumentError nwscore(nothing, nothing; match = 3, mismatch = -3, gap = -2)

end

# Test nwalign
@testset "nwalign" begin
    seq1 = "ACGAT"
    seq2 = "AGGT"
    bestAlignment = Set{String}([("ACGAT", "A-GGT"), ("ACGAT", "AGG-T")])

    @test nwalign(seq1, seq2) == bestAlignment, 1
    @test nwalign(seq1, seq2; match = 2) == bestAlignment, 4
    @test nwalign(seq1, seq2; gap = -2) == bestAlignment, 0
    @test nwalign(seq1, seq2; match = 2, mismatch = -2) == bestAlignment, 3
    @test nwalign(seq1, seq2; match = 2, mismatch = -2, gap = -2) == bestAlignment, 2

end