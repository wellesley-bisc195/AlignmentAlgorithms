function swsetupmatrix(s1, s2)
    setupmatrix = zeros(Int, length(s1)+1, length(s2)+1)
    return setupmatrix
end

function swscorematrix(seq1, seq2; match=1, mismatch=-1, gap=-1)
    scoremat = swsetupmatrix(seq1, seq2)
    for i in 2:size(scoremat, 1) # iterate through row indices
        for j in 2:size(scoremat, 2) # iterate through column indices
            above = nwscore(seq1[i-1], nothing; match, mismatch, gap) + scoremat[i-1,j]
            left = nwscore(nothing, seq2[j-1]; match, mismatch, gap) + scoremat[i,j-1]
            diagonal = nwscore(seq1[i-1], seq2[j-1]; match, mismatch, gap) + scoremat[i-1,j-1]
            scoremat[i,j] = max(above, left, diagonal)
            # or `scoremat[i,j] = max(above, left, diagonal, 0)`

            if scoremat[i,j] < 0 
                scoremat[i,j] = 0
            end
        end
    end
    return scoremat
end