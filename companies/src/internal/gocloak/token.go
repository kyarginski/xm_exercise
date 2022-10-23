package gocloak

import (
	"companies/src/internal/config"
	"companies/src/internal/model"
	"context"
	"errors"
	"github.com/Nerzal/gocloak/v9"
	"github.com/gin-gonic/gin"
	"net/http"
)

// ValidateAuth Authentication verification.
func ValidateAuth() gin.HandlerFunc {
	return func(c *gin.Context) {
		authorisationHeader := c.Request.Header.Get("Authorization")
		// make sure authorisation header is not empty
		if authorisationHeader != "" {
			err := parseToken(authorisationHeader)
			if err != nil { // An incorrect token usually returns a 403 http code
				c.AbortWithStatusJSON(http.StatusForbidden, model.GenericMessage{Status: http.StatusForbidden, Message: err.Error()})

				return
			}
			c.Next()
		} else {
			errMessage := "An authorization header is required"
			c.AbortWithStatusJSON(http.StatusUnauthorized, model.GenericMessage{Status: http.StatusUnauthorized, Message: errMessage})
		}
	}
}

// ParseToken parsing token
func parseToken(token string) error {
	client := gocloak.NewClient(config.Cfg.Keycloak.Server)
	ctx := context.Background()
	realm := config.Cfg.Keycloak.Realm
	clientSecret := config.Cfg.Keycloak.ClientSecret
	clientID := config.Cfg.Keycloak.ClientID

	rptResult, err := client.RetrospectToken(ctx, token, clientID, clientSecret, realm)
	if err != nil {
		return err
	}

	if !*rptResult.Active {
		errMessage := "token is not active"

		return errors.New(errMessage)
	}

	return nil
}
