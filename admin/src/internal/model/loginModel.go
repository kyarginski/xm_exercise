package model

// A LoginModel Login model.
// swagger:model
type LoginModel struct {
	Status           string   `json:"status"`
	Type             string   `json:"type"`
	CurrentAuthority []string `json:"currentAuthority"`
	TokenA           string   `json:"tokenA"`
	TokenR           string   `json:"tokenR"`
}
