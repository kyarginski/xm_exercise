package companies

import (
	"companies/src/internal/config"
	"companies/src/internal/database"
	"companies/src/internal/model"
	"fmt"
	"github.com/fatih/structs"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"gorm.io/gorm"
	"net/http"
	"time"
)

// GetCompanyById Get company by ID.
func GetCompanyById(c *gin.Context) {
	// swagger:operation  GET /v1.0.0/companies/:id GetCompanyById
	// Get company by ID.
	// ---
	// produces:
	// - application/json
	// parameters:
	// - in: query
	//   name: id
	//   description: id company
	//   required: true
	//   type: integer
	// responses:
	//   '200':
	//     description: OK
	//     schema:
	//       $ref: '#/definitions/Company'
	//   '404':
	//     description: Error
	//     schema:
	//       $ref: '#/definitions/GenericMessage'
	//   '400':
	//     description: Error
	//     schema:
	//       $ref: '#/definitions/GenericMessage'
	//   '500':
	//     description: Internal Server error
	//     schema:
	//       $ref: '#/definitions/GenericMessage'

	queryParams := c.Request.URL.Query()

	zap.L().Debug(fmt.Sprintf("Get GetCompanyById with %v", queryParams))

	idName := "id"
	idValue := c.Param(idName)

	db := database.SetConnection(&config.Cfg)
	defer func(db *gorm.DB) {
		sqlDB, err := db.DB()
		if err != nil {
			zap.L().Warn(err.Error())
		}
		if sqlDB != nil {
			err = sqlDB.Close()
			if err != nil {
				zap.L().Warn(err.Error())
			}
		}
	}(db)

	var Company model.Company

	if err := db.Where(idName+" = ?", idValue).First(&Company).Error; err != nil {
		c.AbortWithStatusJSON(http.StatusNotFound, gin.H{"status": http.StatusNotFound, "message": err.Error() + "; " + idName + "=" + idValue})
	} else {
		c.JSON(http.StatusOK, Company)
	}
}

// CompanyInsert Create company.
func CompanyInsert(c *gin.Context) {
	// swagger:operation POST /v1.0.0/companies CompanyInsert
	// Create record of company.
	// ---
	// produces:
	// - application/json
	// parameters:
	// - name: Body
	//   in: body
	//   description: parameters for company
	//   schema:
	//     "$ref": "#/definitions/Company"
	//   required: true
	// responses:
	//   '200':
	//     description: OK
	//   '500':
	//     description: Error

	queryParams := c.Request.URL.Query()

	zap.L().Debug(fmt.Sprintf("Post CompanyInsert с with %v", queryParams))

	var company model.Company

	err := c.BindJSON(&company)
	if err != nil {
		c.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{"status": http.StatusInternalServerError, "message": err.Error()})
	} else {
		db := database.SetConnection(&config.Cfg)
		defer func(db *gorm.DB) {
			sqlDB, err := db.DB()
			if err != nil {
				zap.L().Warn(err.Error())
			}
			if sqlDB != nil {
				err = sqlDB.Close()
				if err != nil {
					zap.L().Warn(err.Error())
				}
			}
		}(db)

		if err := db.Create(&company).Error; err != nil {
			c.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{"status": http.StatusInternalServerError, "message": err.Error()})
			return
		} else {
			c.JSON(http.StatusOK, company)
		}
	}

}

// CompanyUpdate Update company.
func CompanyUpdate(c *gin.Context) {
	// swagger:operation PATCH /v1.0.0/companies CompanyUpdate
	// Update record of company.
	// ---
	// produces:
	// - application/json
	// parameters:
	// - name: Body
	//   in: body
	//   description: parameters for company
	//   schema:
	//     "$ref": "#/definitions/Company"
	//   required: true
	// responses:
	//   '200':
	//     description: OK
	//   '500':
	//     description: Error

	queryParams := c.Request.URL.Query()

	zap.L().Debug(fmt.Sprintf("Вызвали CompanyUpdateResult с параметрами %v", queryParams))

	var company model.Company

	err := c.BindJSON(&company)
	if err != nil {
		c.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{"status": http.StatusInternalServerError, "message": err.Error()})
	} else {

		db := database.SetConnection(&config.Cfg)
		defer func(db *gorm.DB) {
			sqlDB, err := db.DB()
			if err != nil {
				zap.L().Warn(err.Error())
			}
			if sqlDB != nil {
				err = sqlDB.Close()
				if err != nil {
					zap.L().Warn(err.Error())
				}
			}
		}(db)

		// update only filled fields
		m := structs.Map(company)
		delete(m, "ID")
		delete(m, "CreatedAt")
		for k, v := range m {
			if v == "" {
				delete(m, k)
			}
		}
		m["UpdatedAt"] = time.Now()

		query := db.Model(&model.Company{}).Where("id = ?", company.ID).Updates(m)
		rowsAffected, err := query.RowsAffected, query.Error

		if err != nil {
			c.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{"status": http.StatusInternalServerError, "message": err.Error()})
			return
		} else {
			if rowsAffected != 0 {
				c.JSON(http.StatusOK, company)
			} else {
				var resultStr = fmt.Sprintf("Record id=%s not found", company.ID)
				c.JSON(http.StatusNoContent, gin.H{"status": http.StatusNoContent, "message": resultStr})
			}
		}
	}
}

// CompanyDelete Delete company.
func CompanyDelete(c *gin.Context) {
	// swagger:operation DELETE /v1.0.0/companies CompanyDelete
	// Delete record of company.
	// ---
	// produces:
	// - application/json
	// parameters:
	// - in: query
	//   name: id
	//   description: id of company
	//   required: true
	//   type: integer
	//   schema:
	//     "$ref": "#/definitions/Company"
	// responses:
	//   '200':
	//     description: OK
	//   '500':
	//     description: Error

	idName := "id"
	idValue := c.Param(idName)

	zap.L().Debug(fmt.Sprintf("Delete CompanyDelete with %s = %v", idName, idValue))

	db := database.SetConnection(&config.Cfg)
	defer func(db *gorm.DB) {
		sqlDB, err := db.DB()
		if err != nil {
			zap.L().Warn(err.Error())
		}
		if sqlDB != nil {
			err = sqlDB.Close()
			if err != nil {
				zap.L().Warn(err.Error())
			}
		}
	}(db)

	if err := db.Where(idName+" = ?", idValue).Delete(model.Company{}).Error; err != nil {
		c.AbortWithStatusJSON(http.StatusNotFound, gin.H{"status": http.StatusNotFound, "message": fmt.Sprintf("%s; %s=%v", err.Error(), idName, idValue)})
		return
	} else {
		c.JSON(http.StatusOK, gin.H{"status": http.StatusOK, "message": fmt.Sprintf("Record %v has been deleted", idValue)})
	}

}
