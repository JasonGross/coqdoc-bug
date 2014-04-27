#!/bin/bash

set -x

if [ -z "$COQC" ]; then
    COQC="${COQBIN}coqc"
fi
if [ -z "$COQTOP" ]; then
    COQTOP="${COQBIN}coqtop"
fi
if [ -z "$COQ_MAKEFILE" ]; then
    COQ_MAKEFILE="${COQBIN}coq_makefile"
fi
if [ -z "$COQDOC" ]; then
    COQDOC="${COQBIN}coqdoc"
fi
echo "COQBIN=$COQBIN"
echo "COQTOP=$COQTOP"
echo "COQC=$COQC"
echo "COQ_MAKEFILE=$COQ_MAKEFILE"
echo "COQDOC=$COQDOC"

"$COQC" --version
echo | "$COQTOP"

rm -f *.css *.v.d *.vo *.html *.glob *.d Overture.v HomFunctor2.v
touch Overture.v
LANG=en_US.UTF-8
echo "Ensure that this comes out as unicode, C^op \times C \to:"
echo -e "c\xE1\xB5\x92\xE1\xB5\x96 \xC3\x97 C \xE2\x86\x86"
cat > HomFunctor2.v <<EOF
(** * Hom *)
Require Import Overture.
EOF
echo -e "(** ** Definitionn of [hom : C\xE1\xB5\x92\xE1\xB5\x96 \xC3\x97 C \xE2\x86\x92 Set] as a functor *)" >> HomFunctor2.v
echo >> HomFunctor2.v

cat Overture.v
cat HomFunctor2.v

"$COQ_MAKEFILE" Overture.v HomFunctor2.v -R . HoTT | make -f -
"$COQDOC" -utf8 -html -R . HoTT HomFunctor2.v

grep '<a name="lab2">' HoTT.HomFunctor2.html
grep --color='auto' -P -n "[\x80-\xFF]" HoTT.HomFunctor2.html
