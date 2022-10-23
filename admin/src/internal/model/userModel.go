package model

import "time"

// ApUser Users without passwords.
// swagger:model
type ApUser struct {
	Id         uint32     `gorm:"column:id" json:"id"`
	Login      string     `gorm:"column:login" json:"username"`
	Surname    string     `gorm:"column:surname" json:"surname"`
	Firstname  string     `gorm:"column:firstname" json:"firstname"`
	Patronymic string     `gorm:"column:patronymic" json:"patronymic"`
	CreateDt   *time.Time `gorm:"column:create_dt" json:"createDt"`
	EndDt      *time.Time `gorm:"column:end_dt" json:"endDt"`
	Locked     string     `gorm:"column:locked" json:"locked"`
	SecType    string     `gorm:"column:sec_type" json:"secType"`
}

// ApUserFull Users.
// swagger:model
type ApUserFull struct {
	ApUser
	Pwd string `gorm:"column:pwd" json:"password"`
}

func (ApUserFull) TableName() string {
	return "ap_user"
}

type User struct {
	Login    string `json:"login"`
	Password string `json:"password"`
}
