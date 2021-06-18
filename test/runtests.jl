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

    
        #@test nwscore('A', 'T') == -1
        #@test nwscore('A', 'T'; mismatch=-2, match = 3) == -2
        @test nwscore('A', 'T'; mismatch=-2, match = 3, gap=-2) == -2
        @test nwscore(nothing, 'C'; mismatch=-1, match=1, gap =-2) == -2
        @test nwscore(nothing, 'C'; mismatch=-1, match=1) == -1
        @test nwscore('A', nothing; mismatch=-1, match=1) == -1
        @test nwscore(nothing, 'C'; gap =-2) == -2
    
        @test_throws ArgumentError nwscore(nothing, nothing)
        @test_throws ArgumentError nwscore(nothing, nothing; gap=-2)
        @test_throws ArgumentError nwscore(nothing, nothing; mismatch=-1, match=1, gap =-2)
end


