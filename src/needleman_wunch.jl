# Labs 3 & 4

"""
    nwscore(base1, base2; mismatch = -1, match = 1, gap = -1 )

Your documentation here.

This function compares nucleotides for genomic sequences
to see if they are matching=1, mismatching=-1, or gaps=-1.

Ex.)
```
julia> nwscore('A','G')
-1
julia> nwscore('A','A')
1
julia> nwscore('A',nothing)
-1
julia> nwscore(nothing,nothing)
ERROR: ArgumentError: Score for two gaps is not defined
Stacktrace:
[1] nwscore(#unused#::Nothing, #unused#::Nothing)
    @ Main ~/Documents/my_repo/BISC195Labs/src/needleman_wunch.jl:25
[2] top-level scope
    @ REPL[81]:1
```

"""
function nwscore(base1::Char, base2::Char; match = 1, mismatch = -1, gap = -1)
    if base1 == base2
        return match
    else base1 != base2
        return mismatch
    end
end

function nwscore(base::Char, ::Nothing; match = 1, mismatch = -1, gap = -1)
    return gap
end

function nwscore(::Nothing, base::Char; match = 1, mismatch = -1, gap = -1)
    nwscore(base, nothing; gap)
end

function nwscore(::Nothing, ::Nothing)
    throw(ArgumentError("Score for two gaps is not defined"))
end

function nwalign(seq1::String, seq2::String; match =1, mismatch=-1, gap=-1)
    #input sequence 1 (seq1)
    #input sequence 2 (seq2)
    #turn each sequence into an array/vector of characters
    #compare each character based on position (see grid for rules) using nwscore 
    #make sure there is error if 2 nothings
    #determine best alignment depending on score
        #if same score, print both as touple
    #return alignments (seq1, seq2) as an array
end 