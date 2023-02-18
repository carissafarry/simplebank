package main

import (
	"database/sql"
	"github.com/carissafarry/simplebank/api"
	db "github.com/carissafarry/simplebank/db/sqlc"
	"github.com/carissafarry/simplebank/db/util"
	"log"

	_ "github.com/lib/pq" // To talk to the database
)

func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("cannot load config:", err)
	}

	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("Cannot connect to db:", err)
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(config.ServerAddress)
	if err != nil {
		log.Fatal("Cannot start server:", err)
	}
}
