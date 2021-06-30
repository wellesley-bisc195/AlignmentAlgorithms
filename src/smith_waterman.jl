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

function swalign(seq1::String, seq2::String; match =1, mismatch=-1, gap=-1)
    scoremat = nwscorematrix(seq1, seq2; match=match, mismatch=mismatch, gap=gap)
    aligned1 = ""
    aligned2 = ""
    
    #make these while loops instead, update indices only within the conditional statements
    #while i > 1 and while j>1
    maxScore = findmax(scoremat)

    i = maxScore[2][1]
    j = maxScore[2][2]

    while i > 1 && j > 1
            above = scoremat[i-1,j]
            left = scoremat[i,j-1]
            diagonal = scoremat[i-1,j-1]

            #check scores from left, right, diag, and if any match current cell, then add that char to the alignments
            if scoremat[i,j] == nwscore(seq1[i-1], nothing; match, mismatch, gap) + scoremat[i-1,j]
                @info "max is from above"
                aligned1 = aligned1 * seq1[i-1]
                aligned2 = aligned2 * "-"
                #update the traversal indices
                i = i-1
            elseif scoremat[i,j] == nwscore(nothing, seq2[j-1]; match, mismatch, gap) + scoremat[i,j-1]
                @info "max is from left"
                aligned1 = aligned1 * "-"
                aligned2 = aligned2 * seq2[j-1]
                #update the traversal indices
                j = j-1
            else
                @info "max is from diag"
                aligned1 = aligned1 * seq1[i-1]
                aligned2 = aligned2 * seq2[j-1]
                #update the traversal indices
                i = i-1
                j = j-1
            end

    end
    aligned1 = reverse(aligned1)
    aligned2 = reverse(aligned2)
    return t = (aligned1, aligned2)
end