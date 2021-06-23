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

# Test nwsetupmatrix
@testset "Scoring matrix setup" begin
    m = nwsetupmatrix("AATT", "AAGTT")
    
    @test m isa Matrix
    @test size(m, 1) == 5
    @test size(m, 2) == 6
    # @test all(==(0), m) # this no longer works

    @test m[1,1] == 0

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

# Test nwscorematrix
@testset "nwscorematrix" begin
    m = nwscorematrix("ACGAT", "AGGT")

    @test m isa Matrix
    @test size(m, 1) == 6
    @test size(m, 2) == 5

    @test m ==  [0  -1  -2  -3  -4
                -1   1   0  -1  -2
                -2   0   0  -1  -2
                -3  -1   1   1   0
                -4  -2   0   0   0
                -5  -3  -1  -1   1]
end

# Test nwalign
@testset "nwalign" begin
    s1 = "ACGAT"
    s2 = "AGGT"
    bestAlignment = Set([("ACGAT", "A-GGT"), ("ACGAT", "AGG-T")])

    @test nwalign(s1, s2) == (bestAlignment, 1)
    @test nwalign(s1, s2; match = 2) == (bestAlignment, 4)
    @test nwalign(s1, s2; gap = -2) == (bestAlignment, 0)
    @test nwalign(s1, s2; match = 2, mismatch = -2) == (bestAlignment, 3)
    @test nwalign(s1, s2; match = 2, mismatch = -2, gap = -2) == (bestAlignment, 2)
end