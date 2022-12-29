dumpdir=./backup
if [ -d "$dumpdir" ]; then
   rm $dumpdir/*.sql
else
   mkdir $dumpdir
fi
echo Dumping databases to "$dumpdir."
echo '\c' > $dumpdir/prefix.sql

pg_dump -U mattermost -d synapse > $dumpdir/synapse.tmp
cat $dumpdir/prefix.sql  $dumpdir/synapse.tmp > $dumpdir/synapse.sql
rm $dumpdir/synapse.tmp 
rm $dumpdir/prefix.sql

pg_dump -U mattermost -d mattermost > $dumpdir/mattermost.sql
pg_dump -U matrix-mattermost -d matrix-mattermost > $dumpdir/matrix-mattermost.sql
