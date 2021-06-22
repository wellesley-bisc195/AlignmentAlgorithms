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

    # Self test nwaligner()
    #sampleString = "AGCTGTGA"
    #sampleString2 = "ACTGTGG"
    #@test nwaligner(sampleString, sampleString2) isa Array{Array{Char, 1}, 1}
    #@test_throws ArgumentError nwaligner(nothing, nothing)
    #@test nwaligner(sampleString, sampleString2) == [['A', 'G', 'C', 'T', 'G', 'T', 'G', 'A'], ['A', '-', 'C', 'T', 'G', 'T', 'G', 'G']] 
end

    #lab 4 tests
    @testset "Scoring matrix setup" begin
        m = nwsetupmatrix("AATT", "AAGTT")
        
        @test m isa Matrix
        @test size(m, 1) == 5
        @test size(m, 2) == 6
        @test all(==(0), m)
    end

    @testset "Scoring matrix setup" begin
        m = nwsetupmatrix("AATT", "AAGTT")
        
        @test m isa Matrix
        @test size(m, 1) == 5
        @test size(m, 2) == 6
        # @test all(==(0), m) # this no longer works
    
        @test m[1,1] == 0
    
        # I wrote these next two in a way that's slightly opaque, since writing it in a clear way
        # would make it obvious how to write the function in the first place.
        # If you want to know how it works, ask me on Zulip,
        # or if you want to investigate yourself, break it down into individual expressions
        @test all(m[2:end,1] .== (-1 .* (1:(size(m,1)-1)))) # test first column
        @test all(m[1,2:end] .== (-1 .* (1:(size(m,2)-1)))) # test first row
    
        m2 = nwsetupmatrix("AATT", "AAGTT"; gap=-2)
        
        @test m2 isa Matrix
        @test size(m2, 1) == 5
        @test size(m2, 2) == 6
    
        @test m2[1,1] == 0
        @test all(m2[2:end,1] .== (-2 .* (1:(size(m2,1)-1)))) # test first column
        @test all(m2[1,2:end] .== (-2 .* (1:(size(m2,2)-1)))) # test first row
    end

    @testset "Testing scored matrix" begin
        scored_m1 = nwscoredmatrix("AGGT", "ACGAT"; gap = -1)
        scored_m2 = nwscoredmatrix("AAT", "GCTGAC"; gap = -2)

        @test scored_m1 isa Matrix
        @test size(scored_m1, 1) == 6
        @test size(scored_m1, 2) == 5
        @test scored_m1 == [0 -1 -2 -3 -4; -1 1 0 -1 -2; -2 0 0 -1 -2; -3 -1 1 1 0; -4 -2 0 0 0; -5 -3 -1 -1 1]
       
        @test scored_m2 isa Matrix
        @test size(scored_m2, 1) == 7
        @test size(scored_m2, 2) == 4
        @test scored_m2 == [0 -2 -4 -6; -2 -1 -3 -5; -4 -3 -2 -4; -6 -5 -4 -1; -8 -7 -6 -3; -10 -7 -6 -5; -12 -9 -8 -7] 
    end

