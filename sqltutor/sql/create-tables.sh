# 1. create databaze DBNAME
#    create schema sqltutor
#    create user DBUSER
#    create language plpgsql
# 
#         createdb DBNAME
#         su -
#         su - postgres
#         createuser DBUSER
#         psql
#         ALTER USER DBUSER WITH PASSWORD 'xxx';
#         psql DBNAME
#         CREATE LANGUAGE plpgsql;
# 
# 2. set bash variables DBNAME and DBUSER if necessary
# 
# 3. run ./create-tables.sh 


if [ "XX$DBNAME" = "XX" -o "XX$DBUSER" = "XX" ]; then

echo ERROR: variables \$DBNAME and \$DBUSER must be both defined
exit 1

fi 


echo -e "\ncreating tables"
echo       =============== 

for file in  datasets.sql dataset_sources.sql questions.sql log.sql
do
  echo -e "\n   " psql $DBNAME "<" $file "\n"
  psql $DBNAME < $file 
done


echo -e "\ngranting privileges"
echo -e   "===================\n"

for t in answers questions questions_categories categories \
         datasets dataset_sources
do
   echo REVOKE ALL   ON TABLE sqltutor.$t FROM PUBLIC ";" \
        GRANT SELECT ON TABLE sqltutor.$t TO $DBUSER ";" | psql $DBNAME
done

for t in tutorials questions datasets dataset_sources
do
   echo GRANT SELECT ON TABLE sqltutor.$t TO PUBLIC ";" | psql $DBNAME
done 

for t in sessions sessions_answers
do 
   echo REVOKE ALL ON TABLE   sqltutor.$t FROM PUBLIC ";" \
        GRANT INSERT ON TABLE sqltutor.$t TO $DBUSER ";" \
        GRANT UPDATE ON TABLE sqltutor.$t TO $DBUSER ";" \
        GRANT SELECT ON TABLE sqltutor.$t TO $DBUSER ";" | psql $DBNAME
done

for t in sessions_session_id_seq; \
do 
   echo REVOKE ALL ON TABLE   sqltutor.$t FROM PUBLIC ";" \
        GRANT UPDATE ON TABLE sqltutor.$t TO $DBUSER ";" \
        GRANT SELECT ON TABLE sqltutor.$t TO $DBUSER ";" | psql $DBNAME
done

for t in sessions sessions_answers; 
do 
   echo REVOKE ALL ON TABLE   sqltutor.$t FROM PUBLIC ";" \
        GRANT INSERT ON TABLE sqltutor.$t TO $DBUSER ";" \
        GRANT UPDATE ON TABLE sqltutor.$t TO $DBUSER ";" \
        GRANT SELECT ON TABLE sqltutor.$t TO $DBUSER ";" | psql $DBNAME;
done

for t in sessions_session_id_seq; 
do 
   echo REVOKE ALL ON TABLE   sqltutor.$t FROM PUBLIC ";" \
        GRANT UPDATE ON TABLE sqltutor.$t TO $DBUSER ";" \
        GRANT SELECT ON TABLE sqltutor.$t TO $DBUSER ";" | psql $DBNAME; 
done


echo -e "\ncreating functions"
echo       ================== 

for func in  next_question.sql open_session.sql
do
  echo -e "\n   " psql $DBNAME "<" $func "\n"
  psql $DBNAME < $func 
done

echo -e "\ngranting privileges to FUNCTION sqltutor.next_question(integer, char(32))"
psql $DBNAME -c "REVOKE ALL ON FUNCTION sqltutor.next_question(integer, char(32)) FROM PUBLIC;"
psql $DBNAME -c "GRANT EXECUTE ON FUNCTION sqltutor.next_question(integer, char(32)) TO PUBLIC;"

