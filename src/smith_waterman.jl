
function swscore(base1::Char, base2::Char; match = 1, mismatch = -1, gap = -1)
    if base1 == base2
        return match
    else base1 != base2
        return mismatch
    end
end

function swscore(base::Char, ::Nothing; match = 1, mismatch = -1, gap = -1)
    return gap
end

function swscore(::Nothing, base::Char; match = 1, mismatch = -1, gap = -1)
    swscore(base, nothing; gap)
end

function swscore(::Nothing, ::Nothing)
    throw(ArgumentError("Score for two gaps is not defined"))
end


function swsetupmatrix(s1, s2)
    setupmatrix = zeros(Int, length(s1)+1, length(s2)+1)
    # matrix can just be filled with zeros
    return setupmatrix
end


function swscorematrix(seq1, seq2; match=1, mismatch=-1, gap=-1)
    scoremat = swsetupmatrix(seq1, seq2)
    for i in 2:size(scoremat, 1) # iterate through row indices
        for j in 2:size(scoremat, 2) # iterate through column indices
            above = swscore(seq1[i-1], nothing; match, mismatch, gap) + scoremat[i-1,j]
            left = swscore(nothing, seq2[j-1]; match, mismatch, gap) + scoremat[i,j-1]
            diagonal = swscore(seq1[i-1], seq2[j-1]; match, mismatch, gap) + scoremat[i-1,j-1]
            #check if the max score is below 0, if it is then just make scoremat[i,j] = 0

            if max(above, left, diagonal) < 0
                scoremat[i,j] = 0
            else
                scoremat[i,j] = max(above, left, diagonal)
            end

        end
    end
    return scoremat
end