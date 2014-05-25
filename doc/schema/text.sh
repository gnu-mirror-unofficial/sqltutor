# g++ -o premp premp.cpp
# ./premp < premp.schema > schema.mp
# mpost schema.mp
# mv schema.1 schema.eps
# epstopdf schema.eps      ## pdflatex demo.tex
#                          ## mv demo.pdf schema.pdf
# convert -density 90 schema.pdf schema.png
# ./text.sh > schema.txt
#
grep ^\ *\#.*[abc], premp.schema | sed s/[abc],// | sed s/#//g | \
    sed s/,/,\ /g | \
    awk '{print "      " $1 " (" $4 $5 $6 $7 $8 $9 $10 $11 $12 $13 $14 $15 $16")"}' | \
    sed s/\;// | sed s/,/,\ /g
