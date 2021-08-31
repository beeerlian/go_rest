package handler

import (
	"encoding/json"
	"net/http"
	"news_rest_api/database"

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
		results, _ := database.ExecuteQuery("SELECT tblposts.id,tblposts.PostTitle, tblcategory.CategoryName, tblposts.PostDetails, tblposts.PostImage from tblposts JOIN tblcategory ON tblcategory.id = tblposts.CategoryId", db)
		defer results.Close()

		//convert *sql.Rows data to JSON
		jsonData, err := json.Marshal(jsonify.Jsonify(results))

		if err != nil {
			http.Error(w, "Cannot Get Data", http.StatusInternalServerError)
			break
		}

		w.Write([]byte(jsonData))

	case "POST":
		//get url paramaters
		title := r.URL.Query().Get("title")
		categoryId := r.URL.Query().Get("categoryId")
		postBody := r.URL.Query().Get("postBody")
		image := r.URL.Query().Get("image")

		if title != "" && categoryId != "" && postBody != "" && image != "" {
			postArticleQuery := "INSERT INTO `tblposts` (`id`, `PostTitle`, `CategoryId`, `SubCategoryId`, `PostDetails`, `PostingDate`, `UpdationDate`, `Is_Active`, `PostUrl`, `PostImage`) VALUES (NULL, '" + title + "', '" + categoryId + "', NULL, '" + postBody + "', current_timestamp(), NULL, '1', NULL, '" + image + "')"

			result, err := database.ExecuteQuery(postArticleQuery, db)
			if err != nil {
				break
			}
			defer result.Close()

			jsonData := CheckStatusAndConvertingTheResult(result, err, &w)

			w.Write([]byte(jsonData))
		}

		http.Error(w, "Paramater Not Correct", http.StatusBadRequest)

	case "UPDATE":

		id := r.URL.Query().Get("id")
		categoryId := r.URL.Query().Get("categoryId")
		image := r.URL.Query().Get("image")

		if id != "" && categoryId != "" && image != "" {
			updateQuery := "UPDATE `tblposts` SET `CategoryId` = '" + categoryId + "',`PostImage` = " + image + " WHERE `tblposts`.`id` = " + id + ""

			result, err := database.ExecuteQuery(updateQuery, db)
			if err != nil {
				break
			}
			defer result.Close()

			jsonData := CheckStatusAndConvertingTheResult(result, err, &w)

			w.Write([]byte(jsonData))
		}

		http.Error(w, "Paramater Not Correct", http.StatusBadRequest)

	case "DELETE":

		id := r.URL.Query().Get("id")

		if id != "" {
			updateQuery := "DELETE FROM `tblposts` WHERE `tblposts`.`id` = " + id + ""

			result, err := database.ExecuteQuery(updateQuery, db)
			if err != nil {
				break
			}
			defer result.Close()

			jsonData := CheckStatusAndConvertingTheResult(result, err, &w)

			w.Write([]byte(jsonData))
		}

		http.Error(w, "Paramater Not Correct", http.StatusBadRequest)

	default:
		http.Error(w, "Bad Request", http.StatusBadRequest)
	}
}
