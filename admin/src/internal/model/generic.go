package model

// A GenericMessage is the default message that is generated.
// swagger:model
type GenericMessage struct {
	Status  int32  `json:"status"`
	Message string `json:"message"`
}

// A GenericSimpleDictionary is the simple standard dictionary.
// swagger:model
type GenericSimpleDictionary struct {
	Id   int32  `json:"id"`
	Name string `json:"name"`
}

// A GenericSimpleLink is the simple standard dictionary for links.
// swagger:model
type GenericSimpleLink struct {
	Id1 int32 `json:"id1"`
	Id2 int32 `json:"id2"`
}

// A GenericToken is the message for get token.
// swagger:model
type GenericToken struct {
	Token string `json:"token"`
}
