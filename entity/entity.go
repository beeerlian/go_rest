package entity

type Post struct {
	ID         int    `json:"id"`
	CategoryID int    `json:"CategoryId`
	Title      string `json:"PostTitle"`
	PostDetail string `json:"PostDetails"`
	PostImage  string `json:"PostImage"`
}

type Category struct {
	ID           int    `json:"id`
	CategoryName string `json:"CategoryName"`
}
