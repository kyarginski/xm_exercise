package utils

import (
	"fmt"
	"go.uber.org/zap"
	"net"
	"net/http"
)

type Adapter func(http.Handler) http.Handler

// GetUserIP Получить текущий IP адрес.
func GetUserIP() string {
	var myIP = ""
	addrs, err := net.InterfaceAddrs()
	if err == nil {

		for _, a := range addrs {
			if ipnet, ok := a.(*net.IPNet); ok && !ipnet.IP.IsLoopback() {
				if ipnet.IP.To4() != nil {
					myIP = ipnet.IP.String()
					break
				}
			}
		}

	}
	return myIP
}

/*
//Нотификация об начале и окончании вызова обработчика HTTP-запроса
//Данные пишутся при debug==true

Пример вызова

		router := gin.Default()
		myLoggedRouter := artplast.Notify((Cfg.Settings.RunMode=="debug"))(router)
		srv := &http.Server{
			Addr:    fullServerName,
			Handler: myLoggedRouter,
		}

	  Регистрируются все обработчики
*/
func Notify(debug bool) Adapter {
	return func(h http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			// if debug {
			if false {

				var userName = r.Header.Get("User-Name")
				var traceId = r.Header.Get("Trace-Id")
				var userId = r.Header.Get("User-Id")

				// log.Println("before", r.URL.Path)
				// log.Println("after", r.URL.Path)

				zap.L().Debug(fmt.Sprintf("Before %s", r.URL.Path), zap.String("userName", userName), zap.String("traceId", traceId), zap.String("userId", userId))
				defer zap.L().Debug(fmt.Sprintf("After %s", r.URL.Path), zap.String("userName", userName), zap.String("traceId", traceId), zap.String("userId", userId))
			}
			h.ServeHTTP(w, r)
		})
	}
}
