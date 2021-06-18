# Labs 3 & 4

"""
    nwscore(base1, base2; match, mismatch, gap) --> Int


    Accepts two bases and possibly reassigned match, mismatch, and gap scores, then returns the correct score based on the original Needleman Wunch paper.
    If no bases are given, an error is thrown.

    Examples
    =========
    nwscore(base, nothing) --> -1
    nwscore(base, nothing; gap = -2) --> -2
    nwscore('A', 'T'; mismatch=-2, match = 3, gap=-2) --> -2

"""
function nwscore(base1::Char, base2::Char; match::Int = 1, mismatch::Int = -1, gap::Int = -1)
    if base1 == base2
        return match
    elseif base1 != base2
        return mismatch
    end

end

function nwscore(base::Char, ::Nothing; match::Int = 1, mismatch::Int = -1, gap::Int = -1)
    return gap
end

nwscore(::Nothing, base::Char;  match::Int = 1, mismatch::Int = -1, gap::Int = -1) = nwscore(base, nothing; match = match, mismatch = mismatch, gap = gap)

nwscore(::Nothing, ::Nothing) = throw(ArgumentError("Score for two gaps is not defined"))
nwscore(::Nothing, ::Nothing; match::Int = 1, mismatch::Int = -1, gap::Int = -1) = throw(ArgumentError("Score for two gaps is not defined"))


function nwalign()
    # aligner
end