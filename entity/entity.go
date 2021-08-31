package entity

type Article struct {
	ID           int    `json:"id"`
	CategoryName string `json:"CategoryName"`
	Title        string `json:"PostTitle"`
	PostDetail   string `json:"PostDetails"`
	PostImage    string `json:"PostImage"`
}

type Category struct {
	ID           int    `json:"id"`
	CategoryName string `json:"CategoryName"`
}
