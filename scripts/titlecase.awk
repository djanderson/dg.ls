# Capitalize all words in input except those in the variable "nocap_words".
#
# Usage:
#     echo "test-this-and-that" | awk -f titlecase.awk
#     Test This and That
#
# Modified from https://stackoverflow.com/a/35012145.


BEGIN {
    nocap_words = "a the to at in on with and but or"

    split(nocap_words, nc)
    for (i in nc) {
        nocap[nc[i]]
    }

    FS = "-"
}

{
    for (i = 1; i <= NF; i++) {
        $i = ($i in nocap) ? tolower($i) : capitalize($i)
    }

    print
}

function capitalize(word) {
    return toupper(substr(word, 1, 1)) tolower(substr(word, 2))
}
