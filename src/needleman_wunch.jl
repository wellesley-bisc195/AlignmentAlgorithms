# Labs 3 & 4

"""
    nwscore(base1, base2)

Your documentation here.
"""
function nwscore(base1::Char, base2::Char)
    if base1 == base2
        return 1
        end
    if base1 != base2
        return -1
    end
end

nwscore(base::Char, ::Nothing) = -1
nwscore(::Nothing, base::Char) = nwscore(base, nothing)

nwscore(::Nothing, ::Nothing) = throw(ArgumentError("Score for two gaps is not defined"))
