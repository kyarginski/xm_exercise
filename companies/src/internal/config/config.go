package config

import (
	"errors"
	"go.uber.org/zap"
	"gopkg.in/yaml.v3"
	"log"
	"os"
)

type Conf struct {
	Settings struct {
		AppName       string `yaml:"app_name"`
		VersionNumber string `yaml:"version_number"`
		RunMode       string `yaml:"run_mode"`
	} `yaml:"settings"`
	ClientsCors struct {
		AllowOrigins []string `yaml:"allow_origins"`
	} `yaml:"clients_cors"`
	Keycloak struct {
		Server       string `yaml:"server"`
		Realm        string `yaml:"realm"`
		ClientSecret string `yaml:"client_secret"`
		ClientID     string `yaml:"client_id"`
	} `yaml:"keycloak"`
	Server struct {
		ServerAddress string `yaml:"server_address"`
		ServerPort    int    `yaml:"server_port"`
	} `yaml:"server"`
	Datasource struct {
		ServerDialect string `yaml:"server_dialect"`
		ServerName    string `yaml:"server_name"`
		ServerPort    int    `yaml:"server_port"`
		DbName        string `yaml:"db_name"`
		UserName      string `yaml:"user_name"`
		Pwd           string `yaml:"pwd"`
		Ssl           string `yaml:"ssl"`
	} `yaml:"datasource"`
	Datasets struct {
		SelectUserId string `yaml:"select-user-id"`
	} `yaml:"datasets"`
	MongoDB struct {
		Uri      string `yaml:"uri"`
		Database string `yaml:"database"`
		User     string `yaml:"user"`
		Password string `yaml:"password"`
	} `yaml:"mongodb"`
}

var Cfg Conf

// GetConf Get data from the configuration file.
func (c *Conf) GetConf(fileName string) *Conf {

	yamlFile, err := os.ReadFile(fileName)
	if err != nil {
		log.Panic(err)
	}
	err = yaml.Unmarshal(yamlFile, c)
	if err != nil || (c.Settings.VersionNumber == "" && c.Settings.RunMode == "") {
		log.Panic(errors.New("Not correct format of " + fileName))
	}

	return c
}

// NewLogger Get new logger.
func (c *Conf) NewLogger() *zap.Logger {
	var logger *zap.Logger
	var err error

	if c.Settings.RunMode == "debug" {
		logger, err = zap.NewDevelopment(zap.IncreaseLevel(zap.DebugLevel))
	} else {
		logger, err = zap.NewProduction(zap.IncreaseLevel(zap.ErrorLevel))
	}
	if err != nil {
		log.Fatal(err)
	}

	return logger
}
