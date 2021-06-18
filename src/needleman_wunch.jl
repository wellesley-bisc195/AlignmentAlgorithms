# Labs 3 & 4


"""
    nwscore(base1, base2, ; match= <int>, mismatch= <int>, gap= <int>)

    returns an integer score depending on if the two bases are a match, mismatch, or gap

    default scoring guidelines are as follows: match = 1, mismatch = -1, gap = -1 but can be changed
    in function invocations as one wishes


    Examples
    ==============

    julia> nwscore('G', 'C')
    -1

    julia> nwscore('C', 'A'; mismatch = -3)
    -3

    julia> nwscore('A', 'A')
    1

    julia> nwscore(Nothing, Nothing)
    ArgumentError: "Score for two gaps is not defined"

    julia> nwscore(Nothing, 'A'; gap = -2)
    -2


"""
function nwscore(base1::Char, base2::Char; match=1, mismatch=-1, gap=-1)
    if base1 == base2
        return match
    else
        return mismatch
    end
end

nwscore(base::Char, ::Nothing; match=1, mismatch=-1, gap=-1) = gap
nwscore(::Nothing, base::Char; match=1, mismatch=-1, gap=-1) = nwscore(base, nothing)

nwscore(::Nothing, ::Nothing) = throw(ArgumentError("Score for two gaps is not defined"))

#println(nwscore('G', 'C'))
#println(nwscore('G', 'C'; match = 2, mismatch = -2))
#println(nwscore('A', 'T'; mismatch=-2, match = 3, gap=-2))

function nwaligner(seq1, seq2)
    # aligner
end