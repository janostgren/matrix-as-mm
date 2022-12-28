dumpdir=./backup
if [ -d "$dumpdir" ]; then
   echo
else
   mkdir $dumpdir
fi
echo Dumping databases to "$dumpdir."

pg_dump -U mattermost -d synapse > $dumpdir/synapse.sql
pg_dump -U mattermost -d mattermost > $dumpdir/mattermost.sql
pg_dump -U matrix-mattermost -d matrix-mattermost > $dumpdir/matrix-mattermost.sql
