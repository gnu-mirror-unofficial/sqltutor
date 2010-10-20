grep ^\ *\#.*[abc], premp.schema | sed s/[abc],// | sed s/#//g | \
    sed s/,/,\ /g | \
    awk '{print "      " $1 " (" $4 $5 $6 $7 $8 $9 $10 $11 $12 $13 $14 $15")"}' | \
    sed s/\;// | sed s/,/,\ /g


