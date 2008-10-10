#!/bin/bash


if [ "XX$SQLTUTOR_DATABASE" = "XX" -o "XX$SQLTUTOR_WWW_USER" = "XX" ]; then

echo ERROR: variables \$SQLTUTOR_DATABASE and \$SQLTUTOR_WWW_USER must be both defined
exit 1

fi 


echo -e "\ncreating schema"
echo       =============== 

psql $SQLTUTOR_DATABASE  -c "DROP SCHEMA sqltutor CASCADE;"
psql $SQLTUTOR_DATABASE  -c "CREATE SCHEMA sqltutor;"
psql $SQLTUTOR_DATABASE  -c "GRANT USAGE ON SCHEMA sqltutor TO $SQLTUTOR_WWW_USER;"

 
echo -e "\ncreating tables"
echo       =============== 

psql $SQLTUTOR_DATABASE < sqltutor.sql


echo -e "\ngranting privileges"
echo -e   "===================\n"

for t in answers questions questions_categories categories \
         datasets dataset_sources
do
   echo REVOKE ALL   ON TABLE sqltutor.$t FROM PUBLIC ";" \
        GRANT SELECT ON TABLE sqltutor.$t TO $SQLTUTOR_WWW_USER ";" | psql $SQLTUTOR_DATABASE
done

for t in tutorials questions datasets dataset_sources
do
   echo GRANT SELECT ON TABLE sqltutor.$t TO PUBLIC ";" | psql $SQLTUTOR_DATABASE
done 

for t in sessions sessions_answers
do 
   echo REVOKE ALL ON TABLE   sqltutor.$t FROM PUBLIC ";" \
        GRANT INSERT ON TABLE sqltutor.$t TO $SQLTUTOR_WWW_USER ";" \
        GRANT UPDATE ON TABLE sqltutor.$t TO $SQLTUTOR_WWW_USER ";" \
        GRANT SELECT ON TABLE sqltutor.$t TO $SQLTUTOR_WWW_USER ";" | psql $SQLTUTOR_DATABASE
done

for t in sessions_session_id_seq; \
do 
   echo REVOKE ALL ON TABLE   sqltutor.$t FROM PUBLIC ";" \
        GRANT UPDATE ON TABLE sqltutor.$t TO $SQLTUTOR_WWW_USER ";" \
        GRANT SELECT ON TABLE sqltutor.$t TO $SQLTUTOR_WWW_USER ";" | psql $SQLTUTOR_DATABASE
done

for t in sessions sessions_answers; 
do 
   echo REVOKE ALL ON TABLE   sqltutor.$t FROM PUBLIC ";" \
        GRANT INSERT ON TABLE sqltutor.$t TO $SQLTUTOR_WWW_USER ";" \
        GRANT UPDATE ON TABLE sqltutor.$t TO $SQLTUTOR_WWW_USER ";" \
        GRANT SELECT ON TABLE sqltutor.$t TO $SQLTUTOR_WWW_USER ";" | psql $SQLTUTOR_DATABASE;
done

for t in sessions_session_id_seq; 
do 
   echo REVOKE ALL ON TABLE   sqltutor.$t FROM PUBLIC ";" \
        GRANT UPDATE ON TABLE sqltutor.$t TO $SQLTUTOR_WWW_USER ";" \
        GRANT SELECT ON TABLE sqltutor.$t TO $SQLTUTOR_WWW_USER ";" | psql $SQLTUTOR_DATABASE; 
done


echo -e "\ncreating functions"
echo       ================== 

for func in $(ls *.sql | grep -v sqltutor.sql)
do
  echo -e "\n   " psql $SQLTUTOR_DATABASE "<" $func "\n"
  psql $SQLTUTOR_DATABASE < $func 
done
 
echo -e "\ngranting privileges to FUNCTION sqltutor.next_question(integer, char(32))"
echo -e "REVOKE ALL ON FUNCTION sqltutor.next_question(integer, char(32)) FROM PUBLIC;\n" \
        "GRANT EXECUTE ON FUNCTION sqltutor.next_question(integer, char(32)) TO $SQLTUTOR_WWW_USER;" \
        | psql $SQLTUTOR_DATABASE
 
