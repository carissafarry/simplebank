rmpostgres:
	docker rm postgres15

postgres:
	docker run --name postgres15 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:15-alpine

postgres-bash:
	docker exec -it postgres15 bash

dropdb:
	docker exec -it postgres15 dropdb simple_bank

createdb:
	docker exec -it postgres15 createdb --username=root --owner=root simple_bank

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

startdb:
	docker start postgres15

sqlc:
	docker run --rm -v "D:/Projects/private/simplebank:/src" -w /src kjconroy/sqlc generate

test:
	go test -v -cover ./...

.PHONY: rmpostgres postgres postgres-bash dropdb createdb migratedown migrateup sqlc