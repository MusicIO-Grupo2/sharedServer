# Assumes the database container is named 'db'

#DOCKER_DB_NAME="$(docker-compose ps -q db)"
#DB_HOSTNAME=musicio2
#DB_USER=postgres
#LOCAL_DUMP_PATH="./musicio2.dump"

pg_dump -Fp --dbname=postgresql://postgres:postgres@127.0.0.1:5432/musicio2 > ./init_scripts/musicio2.sql


#docker-compose up -d db
#docker exec -i "${DOCKER_DB_NAME}" pg_restore -C --clean --no-acl --no-owner -U "${DB_USER}" -d #"${DB_HOSTNAME}" < "${LOCAL_DUMP_PATH}"
#docker-compose stop db
