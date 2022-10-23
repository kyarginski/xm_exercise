package utils

import (
	"admin/src/internal/model"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"net/http"
	"os"
	"path/filepath"
	"time"
)

// AuthPing swagger:route GET /ping ping .
//
// Checking the functionality of the module.
//
// Responses:
//
//	default: GenericMessage
func AuthPing(c *gin.Context) {
	t := time.Now()
	resultStr := filepath.Base(os.Args[0]) + " works fine: " + t.Format("2006-01-02 15:04:05")
	zap.L().Debug(resultStr)
	c.JSON(http.StatusOK, model.GenericMessage{Status: http.StatusOK, Message: resultStr})
}
