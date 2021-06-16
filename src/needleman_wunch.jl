# Labs 3 & 4

"""
    nwscore(base1, base2)

    A fruitful function that takes in two Chars and calculates the Needleman Wunch score by comparing them. 
    It returns an integer score based on the input values. If one of the bases is 'nothing', the score decreases by 1.
    If both bases are 'nothing', score cannot be calculated an throws an ArgumentError.
    Keyword arguments, such as 'match', 'mismatch', and 'gap' can be configured by the user.
    Examples
    ≡≡≡≡≡≡≡≡≡≡
    
    julia> nwscore('A', 'A')
    1
    julia> nwscore('A', 'G', mismatch = -2)
    -2
    julia> nwscore(nothing, 'G', gap = -3)
    -3
"""

function nwscore(base1::Char, base2::Char; match=1, mismatch=-1, gap=-1)
    if(base1 isa Nothing && base2 isa Nothing)
        throw(ArgumentError("Score for two gaps is not defined"))
    elseif(base1 isa Nothing || base2 isa Nothing)
        return gap
    end
    
    if(base1 == base2)
        return match
    else
        return mismatch
    end

end

function nwscore(base1, base2; match=1, mismatch=-1, gap=-1)
    if(base1 isa Nothing && base2 isa Nothing)
        throw(ArgumentError("Score for two gaps is not defined"))
    elseif(base1 isa Nothing || base2 isa Nothing)
        return gap
    end
    
    if(base1 == base2)
        return match
    else
        return mismatch
    end

end

"""
    nwalign()

"""
function nwalign(seq1, seq2)
    # takes put char and string inputs
    str1 = string(seq1)
    str2 = string(seq2)
    # return String if one best alignment, Tuple if multiple best alignments
    # do not return score

end



"""
nwscore(base::Char, ::Nothing) = -1
nwscore(::Nothing, base::Char) = nwscore(base, nothing)

nwscore(::Nothing, ::Nothing) = throw(ArgumentError("Score for two gaps is not defined"))
"""

