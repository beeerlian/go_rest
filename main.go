package main

import (
	"log"
	"net/http"
	"news_rest_api_gorilla_mux/handler"

	_ "github.com/go-sql-driver/mysql"
	"github.com/gorilla/mux"
)

func main() {
	router := mux.NewRouter()
	router.HandleFunc("/article", handler.ArticleHandler).Methods("GET")
	log.Fatal(http.ListenAndServe(":5000", router))

	// mux := http.NewServeMux()

	// mux.HandleFunc("/article", handler.ArticleHandler)
	// mux.HandleFunc("/category", handler.CategoyHandler)

	// fmt.Print("Start Serving in port 8000")
	// err := http.ListenAndServe(":8000", mux)
	// fmt.Print("Error : ", err)

}
