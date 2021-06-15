# Labs 3 & 4

"""
    NWScore(base1, base2)

Your documentation here.
"""
function NWScore(base1::Char, base2::Char)
    
end

NWScore(::Nothing, base::Char) = -1
NWScore(base::Char, ::Nothing) = -1

NWScore(::Nothing, ::Nothing) = throw(ArgumentError("Score for two gaps is not defined"))
