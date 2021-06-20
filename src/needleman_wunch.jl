# Labs 3 & 4

"""
    nwscore(base1, base2)

Your documentation here.
"""
function nwscore(base1::Char, base2::Char; match = nothing, mismatch = nothing)
        kwargs_dict = [key=>value for (key, value) in kwargs]
        if match == nothing && mismatch == nothing && base1 == base2
           return 1
        elseif  match == nothing && mismatch == nothing && base1 != base2
            return -1
        elseif match != nothing
            return match
        elseif mismatch != nothing
            return mismatch
        end
    end
nwscore(base::Char, ::Nothing) = -1
nwscore(::Nothing, base::Char) = nwscore(base, nothing)

nwscore(::Nothing, ::Nothing) = throw(ArgumentError("Score for two gaps is not defined"))
