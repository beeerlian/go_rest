package handler

import (
	"encoding/json"
	"net/http"
	"news_rest_api/database"
	"strconv"
)

func CategoyHandler(w http.ResponseWriter, r *http.Request) {

	//connect to db
	db, _ := database.Connect("mysql", "root:@tcp(127.0.0.1:3306)/newsportal")
	defer db.Close()

	//get request method
	method := r.Method
	switch method {

	case "GET":
		results, _ := database.ExecuteQuery("SELECT * from tblcategory", db)
		defer results.Close()

		//convert *sql.Rows data to Struct
		categoriesData, _ := database.PopulateRowsToCategory(results)
		//convert data in struct model to json
		jsonData, err := json.Marshal(categoriesData)

		if err != nil {
			http.Error(w, "Cannot Get Data", http.StatusInternalServerError)
			break
		}

		w.Write([]byte(jsonData))
	case "POST":
		name := r.URL.Query().Get("name")
		description := r.URL.Query().Get("desc")
		isActiveString := r.URL.Query().Get("isactive")

		//check if parameter is null
		if name != "" && description != "" && isActiveString != "" {
			//parsing isActiveString to Int
			isActive, err := strconv.Atoi(isActiveString)

			//check if isActive not number
			if err == nil && isActive < 2 && isActive > -1 {

				postQuery := "INSERT INTO tblcategory (CategoryName, Description, PostingDate, UpdationDate, Is_Active) VALUES ('" + name + "', '" + description + "', current_timestamp(), NULL, '" + isActiveString + "')"
				result, errQuery := database.ExecuteQuery(postQuery, db)
				jsonData := CheckStatusAndConvertingCategoryResult(result, errQuery, &w)
				w.Write([]byte(jsonData))

			}

		}
		http.Error(w, "Bad Request", http.StatusBadRequest)

	default:
		http.Error(w, "Bad Request", http.StatusBadRequest)
	}
}
