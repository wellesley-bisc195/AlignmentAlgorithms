# Labs 3 & 4

"""
    nwscore(base1, base2; mismatch = -1, match = 1, gap = -1 )

Your documentation here.

This function compares nucleotides for genomic sequences
to see if they are matching=1, mismatching=-1, or gaps=-1.

Ex.)
```
julia> nwscore('A','G')
-1
julia> nwscore('A','A')
1
julia> nwscore('A',nothing)
-1
julia> nwscore(nothing,nothing)
ERROR: ArgumentError: Score for two gaps is not defined
Stacktrace:
[1] nwscore(#unused#::Nothing, #unused#::Nothing)
    @ Main ~/Documents/my_repo/BISC195Labs/src/needleman_wunch.jl:25
[2] top-level scope
    @ REPL[81]:1
```

"""
function nwscore(base1::Char, base2::Char; match = 1, mismatch = -1, gap = -1)
    if base1 == base2
        return match
    else base1 != base2
        return mismatch
    end
end

function nwscore(base::Char, ::Nothing; match = 1, mismatch = -1, gap = -1)
    return gap
end

function nwscore(::Nothing, base::Char; match = 1, mismatch = -1, gap = -1)
    nwscore(base, nothing; gap)
end

function nwscore(::Nothing, ::Nothing)
    throw(ArgumentError("Score for two gaps is not defined"))
end

# function nwalign(seq1::String, seq2::String; match =1, mismatch=-1, gap=-1)
#     #input sequence 1 (seq1)
#     #input sequence 2 (seq2)
#     #turn each sequence into an array/vector of characters
#     #compare each character based on position (see grid for rules) using nwscore 
#     #make sure there is error if 2 nothings
#     #determine best alignment depending on score
#         #if same score, print both as touple
#     #return alignments (seq1, seq2) as an array
# end 

function nwsetupmatrix(s1, s2; gap=-1)
    setupmatrix = zeros(Int, length(s1)+1, length(s2)+1)
    for j in 1:length(s2)+1
        setupmatrix[1, j] = (j-1)*gap
    end
    for i in 1:length(s1)+1
        setupmatrix[i,1] = (i-1)*gap
    end
    return setupmatrix
end

function nwscorematrix(seq1, seq2; match=1, mismatch=-1, gap=-1)
    scoremat = nwsetupmatrix(seq1, seq2; gap=gap)
    for i in 2:size(scoremat, 1) # iterate through row indices
        for j in 2:size(scoremat, 2) # iterate through column indices
            above = nwscore(seq1[i-1], nothing; match, mismatch, gap) + scoremat[i-1,j]
            left = nwscore(nothing, seq2[j-1]; match, mismatch, gap) + scoremat[i,j-1]
            diagonal = nwscore(seq1[i-1], seq2[j-1]; match, mismatch, gap) + scoremat[i-1,j-1]
            scoremat[i,j] = max(above, left, diagonal)
        end
    end
    return scoremat
end

#=function tracealign(scoremat)
    i= size(scoremat, 1)
    j= size(scoremat, 2)
    for i in i:scoremat[1,j]
        for j in j:size(scoremat, 2)
            
            if [i,j]== [i, j-1]
                push!(gap, seq1)
                push!(j, seq2)
            elseif [i,j] == [i-1, j] 
                push!(gap, seq2)
                push!(i, seq1)
            elseif [i,j] == [i-1, j-1]
                push!(i, seq1)
                push!(j, seq2)
            end
        end
    end
end=#

i= size(scoremat, 1)
j= size(scoremat, 2)
