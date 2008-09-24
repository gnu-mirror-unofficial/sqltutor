# 1. create databaze SQLTUTORDB
#    create schema sqltutor
#    create user WEBSQLTUTOR
#    create language plpgsql
# 
#         createdb SQLTUTORDB
#         su -
#         su - postgres
#         createuser WEBSQLTUTOR
#         psql
#         ALTER USER WEBSQLTUTOR WITH PASSWORD 'xxx';
#         psql SQLTUTORDB
#         CREATE LANGUAGE plpgsql;
# 
# 2. set bash variables SQLTUTORDB and WEBSQLTUTOR if necessary
# 
# 3. run ./create-database.sh 


if [ "XX$SQLTUTORDB" = "XX" -o "XX$WEBSQLTUTOR" = "XX" ]; then

echo ERROR: variables \$SQLTUTORDB and \$WEBSQLTUTOR must be both defined
exit 1

fi 


echo -e "\ncreating schema"
echo       =============== 

psql $SQLTUTORDB  -c "DROP SCHEMA sqltutor CASCADE;"
psql $SQLTUTORDB  -c "CREATE SCHEMA sqltutor;"
psql $SQLTUTORDB  -c "GRANT USAGE ON SCHEMA sqltutor TO $WEBSQLTUTOR;"

 
echo -e "\ncreating tables"
echo       =============== 

psql $SQLTUTORDB < sqltutor.sql


echo -e "\ngranting privileges"
echo -e   "===================\n"

for t in answers questions questions_categories categories \
         datasets dataset_sources
do
   echo REVOKE ALL   ON TABLE sqltutor.$t FROM PUBLIC ";" \
        GRANT SELECT ON TABLE sqltutor.$t TO $WEBSQLTUTOR ";" | psql $SQLTUTORDB
done

for t in tutorials questions datasets dataset_sources
do
   echo GRANT SELECT ON TABLE sqltutor.$t TO PUBLIC ";" | psql $SQLTUTORDB
done 

for t in sessions sessions_answers
do 
   echo REVOKE ALL ON TABLE   sqltutor.$t FROM PUBLIC ";" \
        GRANT INSERT ON TABLE sqltutor.$t TO $WEBSQLTUTOR ";" \
        GRANT UPDATE ON TABLE sqltutor.$t TO $WEBSQLTUTOR ";" \
        GRANT SELECT ON TABLE sqltutor.$t TO $WEBSQLTUTOR ";" | psql $SQLTUTORDB
done

for t in sessions_session_id_seq; \
do 
   echo REVOKE ALL ON TABLE   sqltutor.$t FROM PUBLIC ";" \
        GRANT UPDATE ON TABLE sqltutor.$t TO $WEBSQLTUTOR ";" \
        GRANT SELECT ON TABLE sqltutor.$t TO $WEBSQLTUTOR ";" | psql $SQLTUTORDB
done

for t in sessions sessions_answers; 
do 
   echo REVOKE ALL ON TABLE   sqltutor.$t FROM PUBLIC ";" \
        GRANT INSERT ON TABLE sqltutor.$t TO $WEBSQLTUTOR ";" \
        GRANT UPDATE ON TABLE sqltutor.$t TO $WEBSQLTUTOR ";" \
        GRANT SELECT ON TABLE sqltutor.$t TO $WEBSQLTUTOR ";" | psql $SQLTUTORDB;
done

for t in sessions_session_id_seq; 
do 
   echo REVOKE ALL ON TABLE   sqltutor.$t FROM PUBLIC ";" \
        GRANT UPDATE ON TABLE sqltutor.$t TO $WEBSQLTUTOR ";" \
        GRANT SELECT ON TABLE sqltutor.$t TO $WEBSQLTUTOR ";" | psql $SQLTUTORDB; 
done


echo -e "\ncreating functions"
echo       ================== 

for func in $(ls *.sql | grep -v sqltutor.sql)
do
  echo -e "\n   " psql $SQLTUTORDB "<" $func "\n"
  psql $SQLTUTORDB < $func 
done
 
echo -e "\ngranting privileges to FUNCTION sqltutor.next_question(integer, char(32))"
echo -e "REVOKE ALL ON FUNCTION sqltutor.next_question(integer, char(32)) FROM PUBLIC;\n" \
        "GRANT EXECUTE ON FUNCTION sqltutor.next_question(integer, char(32)) TO $WEBSQLTUTOR;" \
        | psql $SQLTUTORDB
 
