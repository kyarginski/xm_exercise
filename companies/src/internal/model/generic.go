package model

// GenericMessage is the default message that is generated
// swagger:model
type GenericMessage struct {
	Status  int32  `json:"status"`
	Message string `json:"message"`
}

// GenericSimpleDictionary is the simple standard dictionary
// swagger:model
type GenericSimpleDictionary struct {
	Id   int32  `json:"id"`
	Name string `json:"name"`
}

// GenericToken is the message for get token7
// swagger:model
type GenericToken struct {
	Token string `json:"token"`
}
