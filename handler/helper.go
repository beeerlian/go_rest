package handler

import (
	"database/sql"
	"encoding/json"
	"net/http"
	"news_rest_api_gorilla_mux/database"
)

func CheckStatusAndConvertingArticleResult(result *sql.Rows, err error, w *http.ResponseWriter) (jsonData []byte) {
	if err != nil {
		http.Error(*w, "Error when posting data", http.StatusInternalServerError)
	}

	postModel, _ := database.PopulateRowsToArticle(result)

	jsonData, errConv := json.Marshal(postModel)
	if errConv != nil {
		http.Error(*w, "Error when converting data to json", http.StatusInternalServerError)
	}
	return
}

func CheckStatusAndConvertingCategoryResult(result *sql.Rows, err error, w *http.ResponseWriter) (jsonData []byte) {
	if err != nil {
		http.Error(*w, "Error when posting data", http.StatusInternalServerError)
	}

	categoriesModel, _ := database.PopulateRowsToCategory(result)

	jsonData, errConv := json.Marshal(categoriesModel)
	if errConv != nil {
		http.Error(*w, "Error when converting data to json", http.StatusInternalServerError)
	}
	return
}
