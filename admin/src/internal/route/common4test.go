package route

import (
	"admin/src/internal/model"
	"encoding/json"
	"fmt"
	"github.com/gin-gonic/gin"
	"io"
	"net/http"
	"net/http/httptest"
)

const VersionApi = "/v1.0.0"

var TokenTest string
var Router *gin.Engine

func TestSetTestAuth() {

	w := httptest.NewRecorder()

	req, _ := http.NewRequest("POST", VersionApi+"/auth/authenticate", nil)
	req.Header.Add("User-Name", "gotest")
	req.Header.Add("Trace-Id", "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
	req.Header.Add("User-Id", "-1")
	req.Header.Add("username", "user")
	req.Header.Add("password", "12345678")
	Router.ServeHTTP(w, req)

	if http.StatusOK == w.Code {
		temp, _ := io.ReadAll(w.Body)
		var res model.GenericToken
		_ = json.Unmarshal(temp, &res)
		TokenTest = res.Token
	}
	fmt.Println("TokenTest = ", TokenTest)

}
