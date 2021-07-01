module AlignmentAlgorithms

export nwscore,
       nwsetupmatrix,
       nwscorematrix
#export nwalign

include("needleman_wunsch.jl")
include("smith_waterman.jl")

end
