package main

import (
	"context"
	"fmt"

	"github.com/redis/go-redis/v9"
)

func main() {

	client := redis.NewClient(&redis.Options{
		Addr:     "redis-11685.c323.us-east-1-2.ec2.cloud.redislabs.com:11685",
		Username: "default",                          // use your Redis user. More info https://redis.io/docs/management/security/acl/
		Password: "WvEmcEU9oeW7G13pfh9FehtdkvutMl1c", // use your Redis password
	})

	ctx := context.Background()

	session := map[string]string{"name": "John", "surname": "Smith", "company": "Redis", "age": "29"}
	for k, v := range session {
		err := client.HSet(ctx, "user-session:123", k, v).Err()
		if err != nil {
			panic(err)
		}
	}

	userSession := client.HGetAll(ctx, "user-session:123").Val()
	fmt.Println(userSession)

}
