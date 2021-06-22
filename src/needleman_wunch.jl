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

function nwsetupmatrix(seq1, seq2; gap = -1)
    num_c = length(seq1) +1
    num_r = length(seq2) +1
    baseMatrix = zeros(Int, num_r, num_c)

    if num_c > 1
        for r1ColumnIndex in 2:num_c
            baseMatrix[1, r1ColumnIndex] = (r1ColumnIndex - 1) * gap
        end
    end

    if num_r > 1
        for c1RowIndex in 2:num_r
            baseMatrix[c1RowIndex, 1] = (c1RowIndex - 1) * gap
        end
    end
    return baseMatrix
end

#nwsetupmatrix("ACTG", "AC"; gap = 2.5)

function nwscoredmatrix(seq1, seq2; match = 1, mismatch = -1, gap = -1)
    # in previously defined functions, seq1 is horizontal, seq2 is vertical
        # oops, did not follow suggestion
    # evaluate score coming from cell above, directly left, and left diagonal of current cell
    # final score is the max() of the 3
    # moving from left diagonal can mean +1 or -1 dependong on match or mismatch
    # moving from cell above and left means -1

    # move from [2, 2] to [2, 3], [2, 4] etc then [3, 2], [3, 3]
    # smallest acceptable matrix size is 2 by 2
    scoredMatrix = nwsetupmatrix(seq1, seq2; gap = gap)
    numOfColumns = length(seq1) + 1
    numOfRows = length(seq2) + 1
    for rowIndex in 2:numOfRows
        for columnIndex in 2:numOfColumns
            numInCurrentCell = scoredMatrix[rowIndex, columnIndex]
            scoreAbove = scoredMatrix[rowIndex - 1, columnIndex] + gap
            scoreLeft = scoredMatrix[rowIndex, columnIndex - 1] + gap
            numDiagonalLeft = scoredMatrix[rowIndex - 1, columnIndex - 1]
            seq1Base = seq1[columnIndex - 1]
            seq2Base = seq2[rowIndex - 1]
            scoreDiagonalLeft = numDiagonalLeft + nwscore(seq1Base, seq2Base; match = match, mismatch = mismatch, gap = gap)
           # if seq1[columnIndex - 1] == seq2[rowIndex - 1]
            #    scoreDiagonalLeft = numDiagonalLeft + match
            #else
             #   scoreDiagonalLeft = numDiagonalLeft + mismatch 
            #end
            biggestScore = max(scoreAbove, scoreLeft, scoreDiagonalLeft)
            scoredMatrix[rowIndex, columnIndex] = biggestScore
        end
    end
    return scoredMatrix
end

#testing nwscoredmatrix
#println(nwscoredmatrix("AGGT", "ACGAT"; gap = -1))
#println(nwscoredmatrix("AAT", "GCTGAC"; gap = -2))





























#println(nwsetupmatrix("AATT", "AAGTT", gapScore = -3))
#println(nwsetupmatrix("GGCTGAG", "AATTACTAAGC"; gapScore = -2))
#println(nwsetupmatrix("GG", "AAT"))
###does not work with Floating gapScores
#println(nwsetupmatrix("GG", "AA"; gapScore = -1.3))

#function nwaligner(seq1, seq2)
    # aligner
#end