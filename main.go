package main

import (
	"database/sql"
	"fmt"
	"news_rest_api/entity"

	_ "github.com/go-sql-driver/mysql"
)

func main() {

	db, _ := connect("mysql", "root:@tcp(127.0.0.1:3306)/newsportal")
	defer db.Close()

	fmt.Println("----------------")

	results, _ := executeQuery("SELECT id,PostTitle,CategoryId, PostDetails, PostImage from tblposts", db)
	defer results.Close()

	posts, err := populateStruct(results)

	if err != nil {
		panic(err.Error())
	}

	for _, post := range posts {
		fmt.Println("id : ", post.ID)
		fmt.Println("title : ", post.Title)
		fmt.Println("body : ", post.PostDetail)
		fmt.Println("image : ", post.PostImage)
	}
}

func connect(driver string, databaseSource string) (db *sql.DB, err error) {
	db, err = sql.Open(driver, databaseSource)
	fmt.Println("Try Connecting to MySQL")
	if err != nil {
		panic(err.Error())
	}

	fmt.Println("Connected")
	return
}

func executeQuery(query string, db *sql.DB) (result *sql.Rows, err error) {
	fmt.Println("Try executing query")
	result, err = db.Query(query)
	if err != nil {
		panic(err.Error())
	}
	fmt.Println("Succes")
	return
}

func populateStruct(result *sql.Rows) (postStruct []entity.Post, err error) {
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
