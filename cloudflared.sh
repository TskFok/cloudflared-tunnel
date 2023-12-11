#!/bin/sh
token=$(printenv token)
url=$(curl -s https://api.github.com/repos/cloudflare/cloudflared/releases/latest | jq -r '.assets[] | select(.browser_download_url | endswith("cloudflared-linux-amd64")) | .browser_download_url')
curl -x http://192.168.0.11:7893 -L --output "cloudflared" $url
chmod +x ./cloudflared
./cloudflared tunnel --no-autoupdate --edge-ip-version=6 --protocol=http2 --region=us run --token $token
