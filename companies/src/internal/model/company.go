package model

import "time"

// Company
// swagger:model
type Company struct {
	ID          string     `gorm:"primaryKey;autoIncrement:true;unique" json:"id"`
	Name        string     `db:"name,omitempty" json:"name"`
	Description string     `db:"description,omitempty" json:"description"`
	Amount      int64      `db:"amount" json:"amount"`
	Registered  string     `db:"registered" json:"registered"`
	Type        string     `db:"type" json:"type"`
	CreatedAt   *time.Time `db:"created_at" json:"created_at,omitempty"`
	UpdatedAt   *time.Time `db:"updated_at" json:"updated_at,omitempty"`
}

// Companies
// swagger:model
type Companies []Company

func (Company) TableName() string {
	return "companies"
}
