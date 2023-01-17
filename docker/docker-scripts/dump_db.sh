dumpdir=./backup
if [ -d "$dumpdir" ]; then
   rm $dumpdir/*.sql
else
   mkdir $dumpdir
fi
echo Dumping databases to "$dumpdir."
echo '\c synapse' > $dumpdir/prefix.sql

pg_dump -U mattermost -d synapse > $dumpdir/synapse.tmp
cat $dumpdir/prefix.sql  $dumpdir/synapse.tmp > $dumpdir/synapse.sql

pg_dump -U mattermost -d mattermost > $dumpdir/mattermost.sql
pg_dump -U matrix-mattermost -d matrix-mattermost > $dumpdir/matrix-mattermost.tmp
echo '\c matrix-mattermost' > $dumpdir/prefix.sql
cat $dumpdir/prefix.sql  $dumpdir/matrix-mattermost.tmp > $dumpdir/matrix-mattermost.sql
rm $dumpdir/prefix.sql
rm $dumpdir/*.tmp 
