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

    
    @test nwscore('A', 'T') == -1
    @test nwscore('A', 'T'; mismatch=-2, match = 3) == -2
    @test nwscore('A', 'T'; mismatch=-2, match = 3, gap=-2) == -2
    @test nwscore(nothing, 'C'; mismatch=-1, match=1, gap =-2) == -2
    @test nwscore(nothing, 'C'; mismatch=-1, match=1) == -1
    @test nwscore('A', nothing; mismatch=-1, match=1) == -1
    @test nwscore(nothing, 'C'; gap =-2) == -2

    @test_throws ArgumentError nwscore(nothing, nothing)
    @test_throws ArgumentError nwscore(nothing, nothing; gap=-2)
    @test_throws ArgumentError nwscore(nothing, nothing; mismatch=-1, match=1, gap =-2)


    
end

#@testset "Lab03 Step9" begin
    #not sure if this is what is meant by scoring system
    #@test nwalign("AGGT", "ACGAT") == "ACGAT/AGG-T" #returns alignment, but is that a string? best way to show both sequences?
    #@test nwalign("AGT", "AGT"; mismatch=-1, match=2, gap=-2) == "AGT"
   # @test nwalign("AAGATC", "ACGAT"; mismatch=-1, match=2, gap=-2) == "AAGATC/ACGAT-"

#end

@testset "Scoring matrix setup" begin
    m = nwsetupmatrix("AATT", "AAGTT")
    
    @test m isa Matrix
    @test size(m, 1) == 5
    @test size(m, 2) == 6
    #@test all(==(0), m) #no longer works

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





