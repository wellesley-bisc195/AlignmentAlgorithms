using AlignmentAlgorithms
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

<<<<<<< HEAD
    
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
=======
    # Test double gap
        @test_throws ArgumentError nwscore(nothing, nothing)

end

# @testset "nwalign" begin
#     seq1="GCATGCU"
#     seq2="GATTACA"
#     @test any(c-> 
#                 in(c, [("GCATG-CU", "G-ATTACA"),
#                        ("GCA-TGCU", "G-ATTACA"), 
#                        ("GCAT-GCU", "G-ATTACA")
#                     ], nwalign(seq1,seq2)
#                     )
#             )
# end
>>>>>>> main

@testset "Scoring matrix setup" begin
    m = nwsetupmatrix("AATT", "AAGTT")
    
    @test m isa Matrix
    @test size(m, 1) == 5
    @test size(m, 2) == 6
<<<<<<< HEAD
    #@test all(==(0), m) #no longer works
=======
    # @test all(==(0), m) # this no longer works
>>>>>>> main

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
<<<<<<< HEAD
    @test all(m2[1,2:end] .== (-2 .* (1:(size(m2,2)-1)))) # test first row 
end

@testset "Scoring matrix test" begin
    m = nwscorematrix("ACGAT", "AGGT")
    @test m isa Matrix
    @test size(m, 1) == 6
    @test size(m, 2) == 5

    testingm = [0  -1  -2  -3  -4; -1   1   0  -1  -2; -2   0   0  -1  -2; -3  -1   1   1   0; -4  -2   0   0   0; -5  -3  -1  -1   1]
    @test m == testingm
end




=======
    @test all(m2[1,2:end] .== (-2 .* (1:(size(m2,2)-1)))) # test first row
end

@testset "Last matrix test" begin
    m=nwscorematrix("ACGAT","AGGT")

    @test m isa Matrix
    @test size(m, 1) == 6
    @test size(m, 2) == 5
    
    @test m[1,1] == 0
    @test all(m[2:end,1] .== (-1 .* (1:(size(m,1)-1)))) # test first column
    @test all(m[1,2:end] .== (-1 .* (1:(size(m,2)-1)))) # test first row
    
    @test m == [  0  -1  -2  -3  -4; -1   1   0  -1  -2; -2   0   0  -1  -2; -3  -1   1   1   0; -4  -2   0   0   0; -5  -3  -1  -1   1]
end
>>>>>>> main
