package main

import (
	"log"
	"net/http"
	"os"
)

var logger = log.New(os.Stdout, "simple-web-server ", log.LstdFlags|log.Lshortfile|log.Ltime|log.LUTC)

func main() {
	port := getEnv("SERVER_PORT", "80")
	http.HandleFunc("/", hz)
	logger.Println("Server is ready to handle requests at port", port)
	logger.Fatal(http.ListenAndServe(":"+port, nil))
}

func hz(w http.ResponseWriter, r *http.Request) {
	logger.Println(r.UserAgent())
	_, err := w.Write([]byte("ok"))
	if err != nil {
		logger.Println("Error writing response:", err)
	}
}

func getEnv(key, defaultValue string) string {
	value := os.Getenv(key)
	if len(value) == 0 {
		return defaultValue
	}
	return value
}
