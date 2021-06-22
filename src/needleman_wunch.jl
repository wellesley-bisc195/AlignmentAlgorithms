# Labs 3 & 4

"""
    nwscore(base1, base2; match, mismatch, gap) --> Int


    Accepts two bases and possibly reassigned match, mismatch, and gap scores, then returns the correct score based on the original Needleman Wunch paper.
    If no bases are given, an error is thrown.

    Examples
    =========
    nwscore(base, nothing) --> -1
    nwscore(base, nothing; gap = -2) --> -2
    nwscore('A', 'T'; mismatch=-2, match = 3, gap=-2) --> -2

"""
function nwscore(base1::Char, base2::Char; match::Int = 1, mismatch::Int = -1, gap::Int = -1)
    if base1 == base2
        return match
    elseif base1 != base2
        return mismatch
    end

end

function nwscore(base::Char, ::Nothing; match::Int = 1, mismatch::Int = -1, gap::Int = -1)
    return gap
end

nwscore(::Nothing, base::Char;  match::Int = 1, mismatch::Int = -1, gap::Int = -1) = nwscore(base, nothing; match = match, mismatch = mismatch, gap = gap)

nwscore(::Nothing, ::Nothing) = throw(ArgumentError("Score for two gaps is not defined"))
nwscore(::Nothing, ::Nothing; match::Int = 1, mismatch::Int = -1, gap::Int = -1) = throw(ArgumentError("Score for two gaps is not defined"))


function nwalign()
    # aligner
end

function nwsetupmatrix(seq1::String, seq2::String; gap::Int = -1)
    length1 = length(seq1)
    length2 = length(seq2)
    scoringMatrix = zeros(Int, length1+1, length2+1)

    for i in 1:(length1+1)
        
        for j in 1:(length2+1)

            if i == 1
                if j > 1
                    scoringMatrix[i,j] = (j-1) * gap
                end
            end

            if j == 1
                if i > 1
                    scoringMatrix[i,j] = (i-1) * gap
                end
            end
        end
    end

    return scoringMatrix
end


function nwscorematrix(seq1, seq2; match=1, mismatch=-1, gap=-1)
    scoremat = nwsetupmatrix(seq1, seq2; gap=gap)
    for i in 2:size(scoremat, 1) # iterate through row indices
        for j in 2:size(scoremat, 2) # iterate through column indices
            @info "scoring Row $i, Column $j"
            ##needs to look at the 3 boxes and determine the max score among them, then add that to the prev score
            aboveScore = scoremat[i-1, j] + nwscore(seq1[i-1], nothing; gap = gap)
            leftScore = scoremat[i, j-1] + nwscore(nothing, seq2[j-1]; gap = gap)
            diagScore = scoremat[i-1, j-1] + nwscore(seq1[i-1], seq2[j-1]; match=match, mismatch=mismatch, gap = gap)
            println("above: $aboveScore")
            println("left: $leftScore")
            println("diag: $diagScore")
            scoremat[i,j] = max(aboveScore, leftScore, diagScore)
            #println(max(aboveScore, leftScore, diagScore))
        end
    end
    return scoremat
end