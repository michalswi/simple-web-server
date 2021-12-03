package main

import (
	"log"
	"net/http"
	"os"
)

var logger = log.New(os.Stdout, "simple-web-server ", log.LstdFlags|log.Lshortfile|log.Ltime|log.LUTC)
var port = getEnv("SERVER_PORT", "80")

func main() {
	http.HandleFunc("/", hz)
	logger.Println("Server is ready to handle requests at port", port)
	logger.Fatal(http.ListenAndServe(":"+port, nil))
}

func hz(w http.ResponseWriter, r *http.Request) {
	logger.Println(r.UserAgent())
	w.Write([]byte("ok"))
}

func getEnv(key, defaultValue string) string {
	value := os.Getenv(key)
	if len(value) == 0 {
		return defaultValue
	}
	return value
}
