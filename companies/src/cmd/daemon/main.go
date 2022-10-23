// Service for working with the Companies
//
// # Description of the REST API of the service for working with the Companies
//
// Consumes:
// - application/json
//
// Produces:
// - application/json
//
// swagger:meta
package main

import (
	"companies/src/internal/config"
	"companies/src/internal/route"
	"companies/src/internal/utils"
	"context"
	"fmt"
	"go.uber.org/zap"
	"net/http"
	"os"
	"os/signal"
	"strconv"
	"time"
)

// Version of the service is installed automatically at the project build stage (from the VERSION environment variable).
var Version string

func main() {

	config.InitParameters("companies.yml", Version)

	port := os.Getenv("PORT")
	if len(port) == 0 {
		port = strconv.Itoa(config.Cfg.Server.ServerPort)
	}

	var fullServerName = config.Cfg.Server.ServerAddress + ":" + port

	router := route.GetMainEngine()

	myLoggedRouter := utils.Notify(config.Cfg.Settings.RunMode == "debug")(router)

	// Graceful restart or stop
	srv := &http.Server{
		Addr:    fullServerName,
		Handler: myLoggedRouter,
	}

	go func() {
		zap.L().Info(fmt.Sprintf("Listening and serving HTTP on %s", srv.Addr), zap.String("clientIP", utils.GetUserIP()))
		// service connections
		if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
			zap.L().Error(fmt.Sprintf("listen: %s\n", err), zap.String("clientIP", utils.GetUserIP()))
		}
	}()

	// Wait for interrupt signal to gracefully shutdown the server with
	// a timeout of 5 seconds.
	quit := make(chan os.Signal, 1)
	signal.Notify(quit, os.Interrupt)
	<-quit

	zap.L().Info("Shutdown App", zap.String("clientIP", utils.GetUserIP()))

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	if err := srv.Shutdown(ctx); err != nil {
		zap.L().Error(fmt.Sprintf("App Shutdown: %s\n", err), zap.String("clientIP", utils.GetUserIP()))
	}
	zap.L().Info("App exiting", zap.String("clientIP", utils.GetUserIP()))
}
