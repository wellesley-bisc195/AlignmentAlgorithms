# Labs 3 & 4

"""
    nwscore(base1, base2; match = 1, mismatch = -1, gap = -1) -> Int

Returns a match, mismatch, or gap score depending on the type and value of base1 and base2.
The type of base1 and base2 must be Char or nothing, else a type error will be thrown.
If base1 and base2 are equivalent, that consititutes a match.
If base1 and base2 are not equivalent but both are of type Char, that constitutes a mismatch.
If either base1 or base2 is of type Char and the other is of type nothing, that constitutes a gap.
If both base1 and base2 are of type nothing, nwscore will throw an ArgumentError.
The kwargs match, mismatch, and gap have a default value of 1, -1, and -1 respectively.

Examples
≡≡≡≡≡≡≡≡≡≡

nwscore('A', 'A') -> 1
nwscore('A', 'A'; match = 2) -> 2
nwscore('A', 'A'; mismatch = -2) -> 1
nwscore('A', 'A'; match = 2, mismatch = -2, gap = -2) -> 2

nwscore('A', 'C') -> -1
nwscore('A', 'C'; mismatch = -2) -> -2
nwscore('A', 'C'; match = 2) -> -1
nwscore('A', 'C'; match = 2, mismatch = -2, gap = -2) -> -2

nwscore('A', nothing) -> -1
nwscore(nothing, 'C'; gap = -2) -> -2
nwscore('A', nothing; match = 2, mismatch = -2, gap = -2) -> -2
nwscore(nothing, nothing; match = 2, mismatch = -2, gap = -2) -> ArgumentError
"""
function nwscore(base1::Char, base2::Char; match = 1, mismatch = -1, gap = -1)
    return base1 == base2 ? match : mismatch
end

nwscore(base::Char, ::Nothing; match = 1, mismatch = -1, gap = -1) = gap
nwscore(::Nothing, base::Char; match = 1, mismatch = -1, gap = -1) = nwscore(base, nothing; gap = gap)

nwscore(::Nothing, ::Nothing; match = 1, mismatch = -1, gap = -1) = throw(ArgumentError("Score for two gaps is not defined"))

function nwalign()
    # aligner
end
