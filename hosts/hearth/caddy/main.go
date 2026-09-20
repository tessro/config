package main

import (
	_ "github.com/caddy-dns/cloudflare"
	cmd "github.com/caddyserver/caddy/v2/cmd"
	_ "github.com/caddyserver/caddy/v2/modules/standard"
)

func main() {
	cmd.Main()
}
