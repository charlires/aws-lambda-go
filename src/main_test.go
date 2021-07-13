package main

import (
	"context"
	"testing"
)

type Record struct {
	S3 struct {
		Object struct {
			Key       string `json:"key"`
			Size      int    `json:"size"`
			ETag      string `json:"eTag"`
			Sequencer string `json:"sequencer"`
		} `json:"object"`
	} `json:"s3"`
}

func TestHandleRequest(t *testing.T) {
	type args struct {
		ctx   context.Context
		event MyEvent
	}
	tests := []struct {
		name string
		args args
		want error
	}{
		{
			name: "test",
			args: args{
				event: MyEvent{"EventName"},
			},
			want: nil,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got := HandleRequest(tt.args.ctx, tt.args.event)
			if got != tt.want {
				t.Errorf("HandleRequest() = %v, want %v", got, tt.want)
			}
		})
	}
}
