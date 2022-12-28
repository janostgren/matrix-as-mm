docker-compose exec -it postgres bash /dump_db.sh
docker-compose cp postgres:/backup ./
ls -l ./backup
