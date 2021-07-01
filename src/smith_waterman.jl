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
    swscore(base, nothing; gap = gap)
end

function swscore(::Nothing, ::Nothing)
    throw(ArgumentError("Score for two gaps is not defined"))
end

function swsetupmatrix(s1, s2)
    setupmatrix = Array{Any}(undef, length(s1)+1, length(s2)+1)
    for j in 1:length(s2)+1
        setupmatrix[1, j] = Dict(0=>nothing)  
    end
    for i in 1:length(s1)+1
        setupmatrix[i,1] = Dict(0=>nothing)
    end
    for i in 2:length(s1)+1
        for j in 2:length(s2)+1
            setupmatrix[i, j] = Dict()
        end
    end
    return setupmatrix
end

#display(swsetupmatrix("GGTTGACTA", "TGTTACGG"))

function swscorematrix(seq1, seq2; match=1, mismatch=-1, gap=-1)
    scoremat = swsetupmatrix(seq1, seq2)
    for i in 2:size(scoremat, 1) # iterate through row indices
        for j in 2:size(scoremat, 2) # iterate through column indices
            above = swscore(seq1[i-1], nothing; match=match, mismatch=mismatch, gap=gap) + collect(keys(scoremat[i-1,j]))[1]
            left = swscore(nothing, seq2[j-1]; match=match, mismatch=mismatch, gap=gap) + collect(keys(scoremat[i,j-1]))[1]
            diagonal = swscore(seq1[i-1], seq2[j-1]; match=match, mismatch=mismatch, gap=gap) + collect(keys(scoremat[i-1,j-1]))[1]
            
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
            
            scoremat[i,j][max(above, left, diagonal, 0)]=maxScoreDirArr
            #@info max(above, left, diagonal, 0)
            
        end
    end
    return scoremat
end


function swalign(seq1, seq2; match=1, mismatch=-1, gap=-1)
    scoredMatrix = swscorematrix(seq1, seq2; match=match, mismatch=mismatch, gap=gap)
    
    alignedSeq1 = ""
    alignedSeq2 = ""

    maxKey = [0]
    maxKeyCoord = ()

    #starting cell is the cell with the largest score
    for i in 2:length(seq1)+1
        for j in 2:length(seq2)+1
            theKey = collect(keys(scoredMatrix[i, j]))[1]
            if theKey > maxKey[1]
                empty!(maxKey)
                push!(maxKey, theKey)
                maxKeyCoord = i, j 
                #@info maxKeyCoord
            end
        end
    end

    #indices of the cell with the largest score
    i = maxKeyCoord[1]
    j = maxKeyCoord[2]
    theKey = 1 #an arbitrary non-zero number
    while theKey != 0
        theKey = collect(keys(scoredMatrix[i, j]))[1]
        #@info theKey
        #@info [i, j]
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
        theKey = collect(keys(scoredMatrix[i, j]))[1]
    end
    return reverse(alignedSeq1), reverse(alignedSeq2)
end

























#     #traverse through matrix while i>1 and j>1
#     #but first start at the cell in the bottom right corner
#     i = length(seq1) + 1
#     j = length(seq2) + 1
#     while i>1 && j>1
#         theKey = collect(keys(scoredMatrix[i, j]))[1]
#         firstDirec = scoredMatrix[i, j][theKey][1]
#         if firstDirec == "above"
#             alignedSeq2 *= "-"
#             alignedSeq1 *= seq1[i-1]
#             i -= 1
#         elseif firstDirec == "left"
#             alignedSeq1 *= "-"
#             alignedSeq2 *= seq2[j-1]
#             j -= 1 
#         else
#             alignedSeq1 *= seq1[i-1]
#             alignedSeq2 *= seq2[j-1]
#             i -= 1
#             j -= 1
#         end
#     end
#     return reverse(alignedSeq1), reverse(alignedSeq2)
# end

#swscorematrix("GGTTGACTA", "TGTTACGG"; match=3, mismatch=-3, gap=-2)