package route

import (
	"admin/src/internal/config"
	"admin/src/internal/gocloak"
	"admin/src/internal/utils"
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"time"
)

func GetMainEngine() *gin.Engine {

	// Setting the server startup parameter: debug | release
	gin.SetMode(config.Cfg.Settings.RunMode)

	// Set the router as the default one shipped with Gin
	router := gin.Default()

	// Disable log's color
	gin.DisableConsoleColor()

	// we allow the request only from the addresses specified in the parameter Cfg.ClientsCors.AllowOrigins
	// router.Use(cors.Default())

	router.Use(cors.New(cors.Config{
		AllowMethods: []string{"GET", "POST", "PUT", "PATCH", "DELETE", "HEAD", "OPTIONS"},
		AllowHeaders: []string{
			"Origin",
			"Content-Length",
			"Content-Type",
			"Authorization",
			"Accept",
		},

		AllowCredentials: true,
		AllowAllOrigins:  false,
		AllowOrigins:     config.Cfg.ClientsCors.AllowOrigins,
		AllowOriginFunc: func(origin string) bool {
			for _, item := range config.Cfg.ClientsCors.AllowOrigins {
				if origin == item {
					return true
				}
			}
			return false
		},
		MaxAge: 24 * time.Hour,
	}))

	versionPath := "/" + config.Cfg.Settings.VersionNumber

	// Service health check.
	router.GET(versionPath+"/ping", utils.AuthPing)

	// Authentication.
	v0 := router.Group(versionPath + "/auth")
	{
		v0.POST("/authenticate", gocloak.CreateTokenKeycloak)
	}

	// Login.
	v1 := router.Group(versionPath + "/api/")
	{
		v1.POST("login", gocloak.Login)
		v1.POST("logout", gocloak.Logout)
		v1.POST("refresh", gocloak.RefreshTokens)
		v1.GET("user-info", gocloak.GetUserInfo)
		v1.GET("user-info/:login", gocloak.GetUserInfo)
		v1.GET("users", gocloak.GetAllUsersInfo)
		v1.GET("roles", gocloak.GetRealmRoles)
	}

	return router
}
