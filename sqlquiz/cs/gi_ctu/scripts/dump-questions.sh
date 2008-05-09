#!/bin/bash

DB=sqlquiz

for i in $*
do
cat <<EOF > .question.1.tmp
  select datasets.ds_table, datasets.columns
  from questions
       join
       datasets
       on questions.dataset = datasets.dataset
 where id=$i
 order by datasets.ord asc;
EOF

cat <<EOF > .question.2.tmp
  select question
    from questions
   where id=$i;
EOF

echo -e "\n/*" $i
psql -t $DB <  .question.1.tmp | awk -F\| /./'{ print $1 "(" $2 " )" }'
echo
psql -t $DB <  .question.2.tmp | awk -F\| /./'{ print $1 }'
echo -e " */\n\n\n\n"

rm -f .question.1.tmp .question.2.tmp 
done