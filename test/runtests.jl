using BISC195Labs
using Combinatorics
using Test

@testset "Lab03" begin
    bases = collect("ATGC")

    # Test match score
    for base in bases
        @test NWScore(base, base) == 1
        @test NWScore(base, base; match = 2) == 2
    end

    # Test mismatch score
    for (b1, b2) in combinations(bases, 2)
        @test NWScore(b1, b2) == -1
        @test NWScore(b1, b2; mismatch = -2) == -2
    end
    
    # Test gap score
    for (base) in bases
        @test NWScore(base, nothing) == -1
        @test NWScore(nothing, base) == -1
        @test NWScore(base, nothing; gap = -2) == -2
        @test NWScore(nothing, base; gap = -2) == -2
    end

end
