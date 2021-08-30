package handler

import (
	"encoding/json"
	"net/http"
	"news_rest_api/database"
	"strconv"

	"github.com/bdwilliams/go-jsonify/jsonify"
)

func ArticleHandler(w http.ResponseWriter, r *http.Request) {
	//connect to db
	db, _ := database.Connect("mysql", "root:@tcp(127.0.0.1:3306)/newsportal")
	defer db.Close()
	//get request method
	method := r.Method

	switch method {
	case "GET":

		//executing query
		results, _ := database.ExecuteQuery("SELECT id,PostTitle,CategoryId, PostDetails, PostImage from tblposts", db)
		defer results.Close()

		//convert *sql.Rows data to JSON
		jsonData, err := json.Marshal(jsonify.Jsonify(results))

		if err != nil {
			http.Error(w, "Cannot Get Data", http.StatusInternalServerError)
		}

		w.Write([]byte(jsonData))

	case "POST":
		//get url paramaters
		name := r.URL.Query().Get("name")
		description := r.URL.Query().Get("desc")
		isActive := r.URL.Query().Get("isactive")

		err := CheckParamaters(&name, &description, &isActive)

		if err != nil {
			http.NotFound(w, r)
		}

		postQuery := "INSERT INTO tblcategory (CategoryName, Description, PostingDate, UpdationDate, Is_Active) VALUES ('" + name + "', '" + description + "', current_timestamp(), NULL, '" + isActive + "')"

		_, errQuery := database.ExecuteQuery(postQuery, db)

		if errQuery != nil {
			w.Write([]byte("Error when adding data to db"))
			http.NotFound(w, r)
		}

		w.Write([]byte("Success"))

	}
}

func CheckParamaters(name *string, description *string, isActiveString *string) (err error) {

	//checking if parameter nil
	if *name == "" || *description == "" || *isActiveString == "" {
		panic(err.Error())
	}

	//parsing isActiveString to Int
	isActive, err := strconv.Atoi(*isActiveString)

	if err != nil || isActive > 1 || isActive < 0 {
		panic(err.Error())
	}

	return
}
