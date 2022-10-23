package config

import (
	"fmt"
	"go.uber.org/zap"
	"log"
	"os"
	"path"
	"strings"
)

func InitParameters(intFileName string, version string) {
	appName := intFileName
	if appName == "" {
		appName = strings.TrimSuffix(os.Args[0], path.Ext(os.Args[0])) + ".yml"
	}
	Cfg.GetConf(appName)
	logger := Cfg.NewLogger()
	defer func(logger *zap.Logger) {
		err := logger.Sync()
		if err != nil {
			log.Println(err.Error())
		}
	}(logger)
	zap.ReplaceGlobals(logger)

	if len(version) == 0 {
		version = Cfg.Settings.VersionNumber
	}

	zap.L().Info("Starting application", zap.String("name", Cfg.Settings.AppName), zap.String("config", appName))
	zap.L().Info(fmt.Sprintf("Version is [%s]", version))
}
