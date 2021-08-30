package database

import (
	"database/sql"
	"fmt"
	"news_rest_api/entity"

	_ "github.com/go-sql-driver/mysql"
)

func Connect(driver string, databaseSource string) (db *sql.DB, err error) {
	db, err = sql.Open(driver, databaseSource)
	fmt.Println("Try Connecting to MySQL")
	if err != nil {
		panic(err.Error())
	}

	fmt.Println("Connected")
	return
}

func ExecuteQuery(query string, db *sql.DB) (result *sql.Rows, err error) {
	fmt.Println("Try executing query")
	result, err = db.Query(query)
	if err != nil {
		panic(err.Error())
	}
	fmt.Println("Succes")
	return
}

func PopulateToStruct(result *sql.Rows) (postStruct []entity.Post, err error) {
	for result.Next() {
		var post entity.Post

		err := result.Scan(&post.ID, &post.Title, &post.CategoryID, &post.PostDetail, &post.PostImage)

		if err != nil {
			panic(err.Error())
		}

		postStruct = append(postStruct, post)
	}
	return
}
