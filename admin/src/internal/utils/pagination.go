package utils

/*
Pagination data structure
{
    "data": [
        {
        }
    ],
    "total": 10,
    "success": true,
    "pageSize": 10,
    "current": 1
}
*/

import (
	"gorm.io/gorm"
)

// PaggingParam Paggination params.
type PaggingParam struct {
	DB      *gorm.DB
	Page    int
	Limit   int
	OrderBy []string
	// tableName string
	Dialect string
	ShowSQL bool
}

// Paginator for AntDesign Pro pagination
type Paginator struct {
	Data     interface{} `json:"data"`     // data
	Total    int64       `json:"total"`    // total number of records available
	Success  bool        `json:"success"`  // true
	PageSize int         `json:"pageSize"` // the number of records returned in this request/page
	Current  int         `json:"current"`  // the current page of this data chunck
}

func Pagging(p *PaggingParam, dataSource interface{}) (*Paginator, error) {
	db := p.DB

	if p.ShowSQL {
		db = db.Debug()
	}
	if p.Limit == 0 {
		p.Limit = 10
	}
	if len(p.OrderBy) > 0 {
		for _, o := range p.OrderBy {
			if len(o) > 0 {
				db = db.Order(o)
			}
		}
	}

	done := make(chan bool, 1)
	var paginator Paginator
	var count int64

	// go countRecords(db, dataSource, done, &count)
	countRecords(db, dataSource, done, &count)

	// err := db.Set("gorm:query_option", limitAndOffset).Find(dataSource).Error
	err := db.Limit(p.Limit).Offset(p.Page).Find(dataSource).Error
	<-done

	paginator.Data = dataSource

	paginator.Total = count
	paginator.PageSize = p.Limit
	paginator.Current = p.Page

	paginator.Success = true

	return &paginator, err
}

func countRecords(db *gorm.DB, countDataSource interface{}, done chan bool, count *int64) {
	db.Model(countDataSource).Count(count)
	done <- true
}
