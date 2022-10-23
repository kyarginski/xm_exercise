package route

import (
	"companies/src/internal/companies"
	"companies/src/internal/config"
	"companies/src/internal/gocloak"
	"companies/src/internal/utils"
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"net/http"
	"time"
)

const (
	fileDocPath = "./doc/"
	webDocPath  = "/docs"
)

func GetMainEngine() *gin.Engine {

	// debug | release
	gin.SetMode(config.Cfg.Settings.RunMode)

	// Set the router as the default one shipped with Gin
	router := gin.New()

	// Force log's color
	gin.ForceConsoleColor()

	versionPath := "/" + config.Cfg.Settings.VersionNumber

	// documentation
	router.StaticFS(versionPath+webDocPath, http.Dir(fileDocPath))

	// Allowed the request only from the addresses specified in the Cfg.ClientsCors.AllowOrigins
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

	// health check
	router.GET(versionPath+"/ping", utils.GetPing)

	// actions without auth
	// router.GET(versionPath+"/companies/", companies.GetCompaniesAll)
	router.GET(versionPath+"/companies/:id", companies.GetCompanyById)

	// actions with auth
	v1 := router.Group(versionPath)
	v1.Use(gocloak.ValidateAuth())
	{
		// v1.GET("/companies/:id", companies.GetCompanyById)
		v1.POST("/companies", companies.CompanyInsert)
		v1.PATCH("/companies", companies.CompanyUpdate)
		v1.DELETE("/companies/:id", companies.CompanyDelete)
	}

	return router
}
