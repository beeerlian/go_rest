package handler

import (
	"encoding/json"
	"fmt"
	"net/http"
	"news_rest_api_gorilla_mux/database"
	"news_rest_api_gorilla_mux/entity"
)

func ArticleHandler(w http.ResponseWriter, r *http.Request) {
	setupCorsResponse(&w, r)
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
		//convert *sql.Rows data to Struct
		postModel, _ := database.PopulateRowsToArticle(results)
		//convert data in struct model to json
		finalData := map[string][]entity.Article{"data": postModel}
		jsonData, err := json.Marshal(finalData)
		if err != nil {
			http.Error(w, "Cannot Get Data", http.StatusInternalServerError)
			return
		}
		fmt.Print("Procees success, returning json data")
		w.Write(jsonData)
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
				return
			}
			defer result.Close()

			jsonData := CheckStatusAndConvertingArticleResult(result, err, &w)

			w.Write(jsonData)
		}

		http.Error(w, "Paramater Not Correct", http.StatusBadRequest)

	case "UPDATE":

		id := r.URL.Query().Get("id")
		categoryId := r.URL.Query().Get("categoryId")
		image := r.URL.Query().Get("image")

		if id != "" && categoryId != "" && image != "" {
			updateQuery := "UPDATE `tblposts` SET `CategoryId` = '" + categoryId + "',`PostImage` = " + image + ", `UpdationDate` = current_timestamp() WHERE `tblposts`.`id` = " + id + ""

			result, err := database.ExecuteQuery(updateQuery, db)
			if err != nil {
				return
			}
			defer result.Close()

			jsonData := CheckStatusAndConvertingArticleResult(result, err, &w)

			w.Write(jsonData)
		}

		http.Error(w, "Paramater Not Correct", http.StatusBadRequest)

	case "DELETE":

		id := r.URL.Query().Get("id")
		if id != "" {
			updateQuery := "DELETE FROM `tblposts` WHERE `tblposts`.`id` = " + id + ""

			result, err := database.ExecuteQuery(updateQuery, db)
			if err != nil {
				return
			}
			defer result.Close()

			jsonData := CheckStatusAndConvertingArticleResult(result, err, &w)

			w.Write(jsonData)
		}

		http.Error(w, "Paramater Not Correct", http.StatusBadRequest)

	default:
		http.Error(w, "Bad Request", http.StatusBadRequest)
	}
}

func setupCorsResponse(w *http.ResponseWriter, req *http.Request) {
	(*w).Header().Set("Access-Control-Allow-Origin", "*")
	(*w).Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE")
	(*w).Header().Set("Access-Control-Allow-Headers", "Accept, Content-Type, Content-Length, Authorization, connection")
}
