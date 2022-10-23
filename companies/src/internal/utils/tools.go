package utils

import (
	"companies/src/internal/model"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"net/http"
	"os"
	"path/filepath"
	"time"
)

// GetPing Health check.
func GetPing(c *gin.Context) {
	// swagger:operation  GET /ping GetPing
	// Health check.
	// ---
	// produces:
	// - application/json
	// responses:
	//   '200':
	//     description: OK
	//     schema:
	//       $ref: '#/definitions/GenericMessage'

	t := time.Now()
	resultStr := filepath.Base(os.Args[0]) + " works fine: " + t.Format("2006-01-02 15:04:05")
	zap.L().Debug(resultStr)
	c.JSON(http.StatusOK, model.GenericMessage{Status: http.StatusOK, Message: resultStr})
}
