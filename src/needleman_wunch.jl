# Labs 3 & 4


"""
    nwscore(base1, base2)

Your documentation here.
"""
function nwscore(base1::Char, base2::Char; match=1, mismatch=-1, gap=-1)
    if base1 == base2
        return match
    else
        return mismatch
    end
end

nwscore(base::Char, ::Nothing; match=1, mismatch=-1, gap=-1) = gap
nwscore(::Nothing, base::Char) = nwscore(base, nothing)

nwscore(::Nothing, ::Nothing) = throw(ArgumentError("Score for two gaps is not defined"))

println(nwscore('G', 'C'))
println(nwscore('G', 'C'; match = 2, mismatch = -2))
println(nwscore('A', 'T'; mismatch=-2, match = 3, gap=-2))

