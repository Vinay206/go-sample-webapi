package main

import (
    "fmt"
    "net/http"
)

func helloWorld(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hello, World!")
}

func main() {
    http.HandleFunc("/hello", helloWorld)  // Define route

    fmt.Println("Server is listening on port 80...")
    http.ListenAndServe(":80", nil)  // Start server on port 8080
}
