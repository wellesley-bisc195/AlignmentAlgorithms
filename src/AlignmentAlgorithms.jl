module AlignmentAlgorithms

export nwscore,
       nwsetupmatrix,
       nwscorematrix,
       nwalign,
       swscore,
       swsetupmatrix,
       swscorematrix,
       swalign
#export nwalign

include("needleman_wunsch.jl")
include("smith_waterman.jl")

end
