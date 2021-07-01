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
    nwscore(base, nothing; gap = gap)
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
    """sets up a matrix with dimension (rows, columns) where # of rows is length of s1 + 1 and # of columns is length of s2 + 1. Dictionary at position 1,1 will have 0 as a key.
    Dictionaries in the first row: dictionary at pos 1,2 will have the gap score as a key; for every dictionary to its right, the gap score will be incrementing by itself for each dictionary
    moving to the right. Dictionaries in the first column: dictionary at pos 2,1 will have the gap score as a key; for every dictionary below it, the gap score will be inccrementing by itself
    for each dictionary moving down. All header dictionaries will have the value nothing. All other dictionaries are empty and of type Any. 
    """
    #set up a matrix of all zero's
    #setupmatrix = zeros(Int, length(s1)+1, length(s2)+1)
    setupmatrix = Array{Any}(undef, length(s1)+1, length(s2)+1)
    #make the horizontal and vertical "headers" with the appropriate gap scores
    for j in 1:length(s2)+1
        setupmatrix[1, j] = Dict((j-1)*gap=>nothing)  
    end
    for i in 1:length(s1)+1
        setupmatrix[i,1] = Dict((i-1)*gap=>nothing)
    end
    #make the rest of the cells empty dictionaries
    for i in 2:length(s1)+1
        for j in 2:length(s2)+1
            setupmatrix[i, j] = Dict()
        end
    end
    return setupmatrix
end

#baseMat = nwsetupmatrix("AGCT", "AGGCC")
#display(baseMat)


function nwscorematrix(seq1, seq2; match=1, mismatch=-1, gap=-1)
    """Revised version of nwscorematrix(). All cells except the headers are dictionaries, where keys are scores and values are lists of string(s) give
    the direction (e.g. "Above", "Left", "Diagonal") from which the score came from."""
    scoremat = nwsetupmatrix(seq1, seq2;  gap=gap)
    for i in 2:size(scoremat, 1) # iterate through row indices
        for j in 2:size(scoremat, 2) # iterate through column indices
            
            # if i == 2 && j ==2
            #     above = nwscore(seq1[i-1], nothing; match=match, mismatch=mismatch, gap=gap) + scoremat[i-1,j]
            #     left = nwscore(nothing, seq2[j-1]; match=match, mismatch=mismatch, gap=gap) + scoremat[i,j-1]
            #     diagonal = nwscore(seq1[i-1], seq2[j-1]; match=match, mismatch=mismatch, gap=gap) + scoremat[i-1,j-1]
            # else
            above = nwscore(seq1[i-1], nothing; match=match, mismatch=mismatch, gap=gap) + collect(keys(scoremat[i-1,j]))[1]
            left = nwscore(nothing, seq2[j-1]; match=match, mismatch=mismatch, gap=gap) + collect(keys(scoremat[i,j-1]))[1]
            diagonal = nwscore(seq1[i-1], seq2[j-1]; match=match, mismatch=mismatch, gap=gap) + collect(keys(scoremat[i-1,j-1]))[1]
            
            scoresArr =[above, left, diagonal]
            maxScoreVal = maximum(scoresArr)
            maxScoreDirArr = []
            for (index, value) in enumerate(scoresArr)
                if maxScoreVal == value
                    if index == 1
                        push!(maxScoreDirArr, "above")
                    elseif index == 2
                        push!(maxScoreDirArr, "left")
                    else
                        push!(maxScoreDirArr, "diagonal")
                    end
                end
            end
            
            scoremat[i,j][max(above, left, diagonal)]=maxScoreDirArr
        end
    end
    return scoremat
end



#display(nwscorematrix())

function nwalign(seq1, seq2; match=1, mismatch=-1, gap=-1)
    scoredMatrix = nwscorematrix(seq1, seq2; match=match, mismatch=mismatch, gap=gap)
    
    alignedSeq1 = ""
    alignedSeq2 = ""

    #traverse through matrix while i>1 and j>1
    #but first start at the cell in the bottom right corner
    i = length(seq1) + 1
    j = length(seq2) + 1
    while i>1 && j>1
        theKey = collect(keys(scoredMatrix[i, j]))[1]
        firstDirec = scoredMatrix[i, j][theKey][1]
        if firstDirec == "above"
            alignedSeq2 *= "-"
            alignedSeq1 *= seq1[i-1]
            i -= 1
        elseif firstDirec == "left"
            alignedSeq1 *= "-"
            alignedSeq2 *= seq2[j-1]
            j -= 1 
        else
            alignedSeq1 *= seq1[i-1]
            alignedSeq2 *= seq2[j-1]
            i -= 1
            j -= 1
        end
    end
    return reverse(alignedSeq1), reverse(alignedSeq2)
end


        
        

