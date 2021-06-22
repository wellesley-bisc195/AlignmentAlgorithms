# Labs 3 & 4

"""
    nwscore(base1, base2)

Determine Needleman Wunsch score for DNA sequence alignment

Examples
≡≡≡≡≡≡≡≡≡≡

julia> nwscore('A', 'A')
1

julia> nwscore('A', 'T')
-1

julia> nwscore('A', nothing; gap=-4)
-4
"""
function nwscore(base1::Char, base2::Char; match=1, mismatch=-1, gap=-1) 
    if base1 == base 2
      return match
    else
      return mismatch
    end
end

nwscore(base::Char, ::Nothing; gap=-1, match=1, mismatch=-1) = gap
nwscore(::Nothing, base::Char; gap=-1, match=1, mismatch=-1) = nwscore(base, nothing; gap=gap, match=match, mismatch=mismatch)

nwscore(::Nothing, ::Nothing) = throw(ArgumentError("Score for two gaps is not defined"))
