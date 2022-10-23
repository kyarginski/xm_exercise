package gocloak

import (
	"admin/src/internal/config"
	"admin/src/internal/model"
	"admin/src/internal/utils"
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"github.com/Nerzal/gocloak/v9"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"io"
	"net/http"
	"strconv"
	"strings"
)

func CreateTokenKeycloak(c *gin.Context) {

	data, err := io.ReadAll(c.Request.Body)
	if err != nil {
		c.AbortWithStatusJSON(http.StatusUnauthorized, model.GenericMessage{Status: http.StatusUnauthorized, Message: err.Error()})

		return
	}

	user := &model.User{}
	err = json.Unmarshal(data, &user)
	if err != nil {
		c.AbortWithStatusJSON(http.StatusUnauthorized, model.GenericMessage{Status: http.StatusUnauthorized, Message: err.Error()})

		return
	}

	client := gocloak.NewClient(config.Cfg.Keycloak.Server)
	ctx := context.Background()
	realm := config.Cfg.Keycloak.Realm
	clientSecret := config.Cfg.Keycloak.ClientSecret
	clientID := config.Cfg.Keycloak.ClientID
	token, err := client.Login(ctx, clientID, clientSecret, realm, user.Login, user.Password)
	if err != nil {
		c.AbortWithStatusJSON(http.StatusUnauthorized, model.GenericMessage{Status: http.StatusUnauthorized, Message: err.Error()})

		return
	}

	rptResult, err := client.RetrospectToken(ctx, token.AccessToken, clientID, clientSecret, realm)
	if err != nil {
		c.AbortWithStatusJSON(http.StatusUnauthorized, model.GenericMessage{Status: http.StatusUnauthorized, Message: err.Error()})

		return
	}

	if !*rptResult.Active {
		c.AbortWithStatusJSON(http.StatusForbidden, model.GenericMessage{Status: http.StatusForbidden, Message: "Token is not active"})

		return
	}

	info, err := client.GetUserInfo(ctx, token.AccessToken, realm)
	if err != nil {
		c.AbortWithStatusJSON(http.StatusUnauthorized, model.GenericMessage{Status: http.StatusUnauthorized, Message: err.Error()})

		return
	}

	zap.L().Debug(fmt.Sprintf("%v", info))

	jwtToken, mapClaims, err := client.DecodeAccessToken(ctx, token.AccessToken, realm, "")
	if err != nil {
		c.AbortWithStatusJSON(http.StatusUnauthorized, model.GenericMessage{Status: http.StatusUnauthorized, Message: err.Error()})

		return
	}

	zap.L().Debug(fmt.Sprintf("%v", jwtToken))
	zap.L().Debug(fmt.Sprintf("%v", mapClaims))

	c.JSON(http.StatusOK, model.JwtToken{TokenA: token.AccessToken, TokenR: token.RefreshToken})
}

// Login User login.
func Login(c *gin.Context) {
	// swagger:operation POST /v1.0.0/api/login Login
	// User login.
	// ---
	// produces:
	// - application/json
	// parameters:
	// - name: Body
	//   in: body
	//   description: parameters for login
	//   schema:
	//     "$ref": "#/definitions/ApUser"
	//   required: true
	// responses:
	//   '200':
	//     description: OK
	//   '500':
	//     description: Error
	data, err := io.ReadAll(c.Request.Body)
	if err != nil {
		c.AbortWithStatusJSON(http.StatusUnauthorized, model.GenericMessage{Status: http.StatusUnauthorized, Message: err.Error()})

		return
	}

	user := &model.ApUserFull{}
	err = json.Unmarshal(data, &user)
	if err != nil {
		c.AbortWithStatusJSON(http.StatusUnauthorized, model.GenericMessage{Status: http.StatusUnauthorized, Message: err.Error()})

		return
	}

	client := gocloak.NewClient(config.Cfg.Keycloak.Server)
	ctx := context.Background()
	realm := config.Cfg.Keycloak.Realm
	clientSecret := config.Cfg.Keycloak.ClientSecret
	clientID := config.Cfg.Keycloak.ClientID
	token, err := client.Login(ctx, clientID, clientSecret, realm, user.Login, user.Pwd)
	if err != nil {
		c.AbortWithStatusJSON(http.StatusUnauthorized, model.GenericMessage{Status: http.StatusUnauthorized, Message: err.Error()})

		return
	}

	_, mapClaims, err := client.DecodeAccessToken(ctx, token.AccessToken, realm, "")
	if err != nil {
		c.AbortWithStatusJSON(http.StatusUnauthorized, model.GenericMessage{Status: http.StatusUnauthorized, Message: err.Error()})
	}

	var roles []string
	if *mapClaims != nil {
		for k, v := range *mapClaims {
			if k == "realm_access" {
				for _, v2 := range v.(map[string]interface{}) {
					for _, v3 := range v2.([]interface{}) {
						roles = append(roles, v3.(string))
					}
				}
			}
		}
	}

	result := model.LoginModel{
		Status:           "ok",
		Type:             "account",
		CurrentAuthority: roles,
		TokenA:           token.AccessToken,
		TokenR:           token.RefreshToken,
	}
	c.JSON(http.StatusOK, result)

}

// Logout User logout.
func Logout(c *gin.Context) {
	// swagger:operation POST /v1.0.0/api/logout Logout
	// User logout.
	// ---
	// produces:
	// - application/json
	// responses:
	//   '200':
	//     description: OK
	//   '500':
	//     description: Error
	zap.L().Info("Logout")

	c.JSON(http.StatusOK, nil)
}

func GetUserInfo(c *gin.Context) {
	loginName := c.Param("login")
	if len(loginName) == 0 {
		c.AbortWithStatusJSON(http.StatusUnauthorized, model.GenericMessage{Status: http.StatusUnauthorized, Message: "login is not set"})
		return
	}

	token := c.Request.Header.Get("Authorization")
	if len(token) == 0 {
		c.AbortWithStatusJSON(http.StatusUnauthorized, model.GenericMessage{Status: http.StatusUnauthorized, Message: "No Authorization token"})

		return
	}

	// Getting user data from keycloak by login.
	client := gocloak.NewClient(config.Cfg.Keycloak.Server)
	ctx := context.Background()
	realm := config.Cfg.Keycloak.Realm

	info, err := client.GetUserInfo(ctx, token, realm)
	if err != nil {
		c.AbortWithStatusJSON(http.StatusUnauthorized, model.GenericMessage{Status: http.StatusUnauthorized, Message: err.Error()})

		return
	}

	userInfo := model.UserInfo{
		Avatar:      "",
		Signature:   "",
		Title:       "",
		Group:       "",
		NotifyCount: 0,
		UnreadCount: 0,
		Country:     "",
		Access:      *info.PreferredUsername,
		Phone:       "",
	}
	if info.Name != nil {
		userInfo.Name = *info.Name
	}
	if info.Sub != nil {
		userInfo.Userid = *info.Sub
	}
	if info.Email != nil {
		userInfo.Email = *info.Email
	}

	if info.Address != nil {
		userInfo.Address = info.Address.String()
	}

	c.JSON(http.StatusOK, userInfo)

}

func GetAllUsersInfo(c *gin.Context) {
	token := c.Request.Header.Get("Authorization")
	if len(token) == 0 {
		c.AbortWithStatusJSON(http.StatusUnauthorized, model.GenericMessage{Status: http.StatusUnauthorized, Message: "No Authorization token"})

		return
	}

	// Getting user data from keycloak.
	client := gocloak.NewClient(config.Cfg.Keycloak.Server)
	ctx := context.Background()
	realm := config.Cfg.Keycloak.Realm
	params := gocloak.GetUsersParams{}
	users, err := client.GetUsers(ctx, token, realm, params)
	if err != nil {
		gErr, ok := err.(gocloak.APIError)
		if ok {
			c.AbortWithStatusJSON(gErr.Code, model.GenericMessage{Status: int32(gErr.Code), Message: err.Error()})
		} else {
			errStr := strings.Split(err.Error(), " ")
			errCode, _ := strconv.ParseInt(errStr[0], 10, 32)
			c.AbortWithStatusJSON(int(errCode), model.GenericMessage{Status: int32(errCode), Message: err.Error()})
		}

		return
	}
	var paginator utils.Paginator
	paginator.Data = users
	paginator.Total = int64(len(users))
	paginator.PageSize = len(users)
	paginator.Current = 1
	paginator.Success = true

	c.JSON(http.StatusOK, paginator)
}

func GetRealmRoles(c *gin.Context) {
	token := c.Request.Header.Get("Authorization")
	if len(token) == 0 {
		c.AbortWithStatusJSON(http.StatusUnauthorized, model.GenericMessage{Status: http.StatusUnauthorized, Message: "No Authorization token"})

		return
	}

	// Getting data on roles from keycloak.
	client := gocloak.NewClient(config.Cfg.Keycloak.Server)
	ctx := context.Background()
	realm := config.Cfg.Keycloak.Realm
	params := gocloak.GetRoleParams{}
	roles, err := client.GetRealmRoles(ctx, token, realm, params)
	if err != nil {
		gErr, ok := err.(gocloak.APIError)
		if ok {
			c.AbortWithStatusJSON(gErr.Code, model.GenericMessage{Status: int32(gErr.Code), Message: err.Error()})
		} else {
			errStr := strings.Split(err.Error(), " ")
			errCode, _ := strconv.ParseInt(errStr[0], 10, 32)
			c.AbortWithStatusJSON(int(errCode), model.GenericMessage{Status: int32(errCode), Message: err.Error()})
		}

		return
	}

	var paginator utils.Paginator
	paginator.Data = roles
	paginator.Total = int64(len(roles))
	paginator.PageSize = len(roles)
	paginator.Current = 1
	paginator.Success = true

	c.JSON(http.StatusOK, paginator)
}

func ValidateAuth() gin.HandlerFunc {
	return func(c *gin.Context) {
		authorisationHeader := c.Request.Header.Get("Authorization")
		// make sure authorisation header is not empty
		if authorisationHeader != "" {
			err := parseToken(authorisationHeader)
			if err != nil { // An incorrect token usually returns a 403 http code.
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

// parseToken parsing token.
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

// RefreshTokens Refresh tokens.
func RefreshTokens(c *gin.Context) {
	// swagger:operation POST /v1.0.0/api/refresh RefreshTokens
	// Refresh tokens.
	// ---
	// produces:
	// - application/json
	// parameters:
	// - name: Body
	//   in: body
	//   description: parameters for refresh tokens
	//   schema:
	//     "$ref": "#/definitions/JwtToken"
	//   required: true
	// responses:
	//   '200':
	//     description: OK
	//   '500':
	//     description: Error
	refreshToken := c.Request.Header.Get("Authorization")
	// make sure authorisation header is not empty
	if refreshToken != "" {
		err := parseToken(refreshToken)
		if err != nil { // An incorrect token usually returns a 403 http code.
			c.AbortWithStatusJSON(http.StatusForbidden, model.GenericMessage{Status: http.StatusForbidden, Message: err.Error()})

			return
		}

		client := gocloak.NewClient(config.Cfg.Keycloak.Server)
		ctx := context.Background()
		realm := config.Cfg.Keycloak.Realm
		clientSecret := config.Cfg.Keycloak.ClientSecret
		clientID := config.Cfg.Keycloak.ClientID
		tokenNew, err := client.RefreshToken(ctx, refreshToken, clientID, clientSecret, realm)
		if err != nil {
			c.AbortWithStatusJSON(http.StatusUnauthorized, model.GenericMessage{Status: http.StatusUnauthorized, Message: err.Error()})

			return
		}

		result := model.LoginModel{
			Status: "ok",
			Type:   "refresh",
			TokenA: tokenNew.AccessToken,
			TokenR: tokenNew.RefreshToken,
		}
		c.JSON(http.StatusOK, result)

	} else {
		errMessage := "An authorization header is required"
		c.AbortWithStatusJSON(http.StatusUnauthorized, model.GenericMessage{Status: http.StatusUnauthorized, Message: errMessage})
	}
}
