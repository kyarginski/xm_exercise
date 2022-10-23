package model

// UserInfo user's information.
// swagger:model
type UserInfo struct {
	Name        string `json:"name"`
	Avatar      string `json:"avatar"`
	Userid      string `json:"userid"`
	Email       string `json:"email"`
	Signature   string `json:"signature"`
	Title       string `json:"title"`
	Group       string `json:"group"`
	NotifyCount int    `json:"notifyCount"`
	UnreadCount int    `json:"unreadCount"`
	Country     string `json:"country"`
	Access      string `json:"access"`
	Address     string `json:"address"`
	Phone       string `json:"phone"`
}
