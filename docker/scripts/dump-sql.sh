docker-compose exec -it postgres bash -c  ./dump_db.sh
docker-compose cp postgres:/backup/ ./
ls -l ./backup
