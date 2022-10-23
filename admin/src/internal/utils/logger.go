package utils

import (
	"fmt"
	"go.uber.org/zap"
	"net"
	"net/http"
)

type Adapter func(http.Handler) http.Handler

// GetUserIP Get the current IP address.
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

// Notify
/*
 Notification of the beginning and end of the HTTP request handler call.
 Data is written when debug==true

   Example:

	router := gin.Default()
	myLoggedRouter := artplast.Notify((Cfg.Settings.RunMode=="debug"))(router)
	srv := &http.Server{
		Addr:    fullServerName,
		Handler: myLoggedRouter,
	}

	  All handlers are registered
*/
func Notify(debug bool) Adapter {
	return func(h http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			if debug {
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
