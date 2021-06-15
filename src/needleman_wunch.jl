# Labs 3 & 4

"""
    nwscore(base1, base2)

Your documentation here.
"""
function nwscore(base1::Char, base2::Char)
    
end

nwscore(::Nothing, base::Char) = -1
nwscore(base::Char, ::Nothing) = -1

nwscore(::Nothing, ::Nothing) = throw(ArgumentError("Score for two gaps is not defined"))
