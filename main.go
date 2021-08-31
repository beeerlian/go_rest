package main

import (
	"fmt"
	"net/http"

	"news_rest_api/handler"

	_ "github.com/go-sql-driver/mysql"
)

func main() {

	mux := http.NewServeMux()

	mux.HandleFunc("/article", handler.ArticleHandler)
	mux.HandleFunc("/category", handler.CategoyHandler)

	fmt.Print("Start Serving in port 8000")
	err := http.ListenAndServe(":8000", mux)
	fmt.Print("Error : ", err)

}
