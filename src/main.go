package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
)

type MyEvent struct {
	Name string `json:"name"`
}

// https://pkg.go.dev/github.com/aws/aws-lambda-go/events
func HandleRequest(ctx context.Context, event MyEvent) error {
	fmt.Print(event.Name)
	return nil
}

func main() {
	lambda.Start(HandleRequest)
}
