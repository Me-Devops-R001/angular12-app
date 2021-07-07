FROM postgres:latest


ENV POSTGRES_PASSWORD: Trustno1

COPY ./postgresql-sql/* /docker-entrypoint-initdb.d/

EXPOSE 5004
EXPOSE 5432

# TEST COMMANDS BEGIN ----------------------------

# sudo docker build . --tag dbpreloadtest:latest
# sudo docker images
# sudo docker container run -d --rm -p 5432:5432 -e POSTGRES_PASSWORD=Trustno1 -e POSTGRES_USER=postgres --name at_test_preloaded_db-0.0.0.1 dbpreloadtest:latest
# sudo docker container ls
# sudo docker exec --interactive --tty mypostgresqldb psql -h localhost -U postgres

# TEST COMMANDS END ----------------------------


