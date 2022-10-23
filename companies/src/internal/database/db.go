package database

import (
	"companies/src/internal/config"
	"companies/src/internal/utils"
	"fmt"
	"go.uber.org/zap"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
	"gorm.io/gorm/schema"
)

// SetConnection Establish a database connection for GORM.
func SetConnection(c *config.Conf) *gorm.DB {

	// Connection
	// schema://user:password@host[:port]/database?param1=value1&...&paramN=valueN

	userP := ""

	connectionString := ""
	// Create connection string for ClickHouse
	switch c.Datasource.ServerDialect {
	case "clickhouse":
		connectionString = fmt.Sprintf("%s%s:%d/%s",
			userP, c.Datasource.ServerName, c.Datasource.ServerPort, c.Datasource.DbName)
	case "mssql":

		var integratedSecurity = "false"

		if c.Datasource.UserName == "" {
			integratedSecurity = "true"
		}
		connectionString = fmt.Sprintf("server=%s;port=%d;database=%s;integratedSecurity=%s;user id=%s;password=%s",
			c.Datasource.ServerName, c.Datasource.ServerPort, c.Datasource.DbName, integratedSecurity, c.Datasource.UserName, c.Datasource.Pwd)
	case "postgres":
		// "host=myhost port=myport dbname=gorm user=gorm password=mypassword  sslmode=disable"
		ssl := ""
		if c.Datasource.Ssl != "" {
			ssl = c.Datasource.Ssl
		}
		connectionString = fmt.Sprintf("host=%s port=%d dbname=%s user=%s password=%s %s client_encoding=UTF8",
			c.Datasource.ServerName, c.Datasource.ServerPort, c.Datasource.DbName, c.Datasource.UserName, c.Datasource.Pwd, ssl)

		// postgres://postgres:secret@%s/test?sslmode=disable
		// connectionString = "postgres://postgres:postgres@localhost/client_account_dev?sslmode=disable"
	default:
		// mySql
		connectionString = fmt.Sprintf("%s%s/%s?charset=utf8&parseTime=True&loc=Local",
			userP, c.Datasource.ServerName, c.Datasource.DbName)
	}

	db, err := gorm.Open(postgres.New(postgres.Config{
		DSN:                  connectionString,
		PreferSimpleProtocol: true, // disables implicit prepared statement usage. By default pgx automatically uses the extended protocol
	}), &gorm.Config{
		NamingStrategy: schema.NamingStrategy{SingularTable: true},
		Logger:         logger.Default.LogMode(logger.Info),
	})

	if err != nil {
		zap.L().Error(fmt.Sprintf("Connecting: %s\n", connectionString), zap.String("clientIP", utils.GetUserIP()))
	}

	return db
}
