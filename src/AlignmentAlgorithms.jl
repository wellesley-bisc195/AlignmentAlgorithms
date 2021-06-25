module AlignmentAlgorithms

export nwscore,
       nwsetupmatrix,
       nwscorematrix,
       swsetupmatrix,
       swscorematrix
#export nwalign

include("needleman_wunsch.jl")
include("smith_waterman.jl")

end
