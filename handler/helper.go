package handler

import (
	"database/sql"
	"encoding/json"
	"net/http"

	"github.com/bdwilliams/go-jsonify/jsonify"
)

func CheckStatusAndConvertingTheResult(result *sql.Rows, err error, w *http.ResponseWriter) (jsonData []byte) {
	if err != nil {
		http.Error(*w, "Error when posting data", http.StatusInternalServerError)
	}

	jsonData, errConv := json.Marshal(jsonify.Jsonify(result))
	if errConv != nil {
		http.Error(*w, "Error when converting data to json", http.StatusInternalServerError)
	}
	return
}
