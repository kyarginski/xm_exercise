package utils

import "testing"

func TestHashPassword(t *testing.T) {
	type args struct {
		password string
	}
	tests := []struct {
		name string
		args args
	}{
		{
			name: "Password checking",
			args: args{
				password: "user",
			},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := HashPassword(tt.args.password)
			t.Log("password hash =", got)
			if err != nil {
				t.Errorf("HashPassword() error = %v", err)
				return
			}

			if !CheckPasswordHash(tt.args.password, got) {
				t.Errorf("error CheckPasswordHash() got = %v", got)
			}
		})
	}
}
