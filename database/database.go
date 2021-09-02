package database

import (
	"database/sql"
	"fmt"
	"news_rest_api_gorilla_mux/entity"

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
	fmt.Println("Query Succes")
	return
}

func PopulateRowsToArticle(result *sql.Rows) (postStruct []entity.Article, err error) {
	for result.Next() {
		var post entity.Article

		err := result.Scan(&post.ID, &post.Title, &post.CategoryName, &post.PostDetail, &post.PostImage)

		if err != nil {
			panic(err.Error())
		}

		postStruct = append(postStruct, post)
	}
	return
}

func PopulateRowsToCategory(result *sql.Rows) (categoriesStruct []entity.Category, err error) {

	for result.Next() {
		var category entity.Category

		err := result.Scan(&category.ID, &category.CategoryName)

		if err != nil {
			panic(err.Error())
		}

		categoriesStruct = append(categoriesStruct, category)
	}

	return
}
