# Labs 3 & 4


"""
    nwscore(base1, base2, ; match= <int>, mismatch= <int>, gap= <int>)

    returns an integer score depending on if the two bases are a match, mismatch, or gap

    default scoring guidelines are as follows: match = 1, mismatch = -1, gap = -1 but can be changed
    in function invocations as one wishes


    Examples
    ==============

    julia> nwscore('G', 'C')
    -1

    julia> nwscore('C', 'A'; mismatch = -3)
    -3

    julia> nwscore('A', 'A')
    1

    julia> nwscore(Nothing, Nothing)
    ArgumentError: "Score for two gaps is not defined"

    julia> nwscore(Nothing, 'A'; gap = -2)
    -2


"""
function nwscore(base1::Char, base2::Char; match=1, mismatch=-1, gap=-1)
    if base1 == base2
        return match
    else
        return mismatch
    end
end

nwscore(base::Char, ::Nothing; match=1, mismatch=-1, gap=-1) = gap
nwscore(::Nothing, base::Char; match=1, mismatch=-1, gap=-1) = nwscore(base, nothing)

nwscore(::Nothing, ::Nothing) = throw(ArgumentError("Score for two gaps is not defined"))

#println(nwscore('G', 'C'))
#println(nwscore('G', 'C'; match = 2, mismatch = -2))
#println(nwscore('A', 'T'; mismatch=-2, match = 3, gap=-2))

function nwsetupmatrix(seq1, seq2; gapScore = -1)
    num_c = length(seq1) +1
    num_r = length(seq2) +1
    scoringMatrix = zeros(Int, num_r, num_c)

    if num_c > 1
        for r1ColumnIndex in 2:num_c
            scoringMatrix[1, r1ColumnIndex] = (r1ColumnIndex - 1) * gapScore
        end
    end

    if num_r > 1
        for c1RowIndex in 2:num_r
            scoringMatrix[c1RowIndex ,1] = (c1RowIndex - 1) * gapScore
        end
    end

    return scoringMatrix
end

#println(nwsetupmatrix("AATT", "AAGTT", gapScore = -3))
#println(nwsetupmatrix("GGCTGAG", "AATTACTAAGC"; gapScore = -2))
#println(nwsetupmatrix("GG", "AAT"))
###does not work with Floating gapScores
#println(nwsetupmatrix("GG", "AA"; gapScore = -1.3))

#function nwaligner(seq1, seq2)
    # aligner
#end