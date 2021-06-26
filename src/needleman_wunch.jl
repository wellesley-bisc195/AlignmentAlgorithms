# Labs 3 & 4

"""
    nwscore(base1, base2; gap= -1, match= 1, mismatch= -1)

Determine Needleman Wunsch score for DNA sequence alignment
    
Examples
≡≡≡≡≡≡≡≡≡≡

julia> nwscore('A', 'A')
1

julia> nwscore('A', 'T')
-1

julia> nwscore('A', nothing; gap= -4)
-4
"""
function nwscore(base1::Char, base2::Char; match = 1, mismatch= -1, gap= -1)
    if base1 == base2 
        return match 
    end
    if base1 != base2 
        return mismatch
    end
end

nwscore(base::Char, ::Nothing; gap=-1, match= 1, mismatch= -1)= gap
nwscore(::Nothing, base::Char; gap=-1, match=1, mismatch= -1) = nwscore(base, nothing; gap=gap, match=match, mismatch=mismatch)
nwscore(::Nothing, ::Nothing) = throw(ArgumentError("Score for two gaps is not defined"))

function nwalign(seq1::String, seq2::String; match= 1, mismatch = -1, gap=-1)
end

function nwsetupmatrix(seq1::String, seq2::String; gap=-1)
    M = zeros(Int, length(seq1)+1, length(seq2)+1)
    for i in 1:length(seq1)+1
       if i>1 in M[i, 1] == gap*(i-1)
       end
    end
    for j in 1:length(seq2)+1
        if j>1 in M[1, j] == gap*(j-1)
        end
    end
    return M
end

function nwscorematrix(seq1, seq2; match=1, mismatch=-1, gap=-1)
    scoremat = nwsetupmatrix(seq1, seq2; gap=gap)
    for i in 2:size(scoremat, 1) # iterate through row indices
        for j in 2:size(scoremat, 2) # iterate through column indices
            @info "scoring Row $i, Column $j"
            above=  max(M[i-1, j])
            left= max(M[i, j-1])
            diagonal= max(M[i-1, j-1])
        end
        scoremat[i, j] = (above, left, diagonal)
    end
    return scoremat
end