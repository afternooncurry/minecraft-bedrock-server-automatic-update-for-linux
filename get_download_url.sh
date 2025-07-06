
DATA=`curl -s 'https://net-secondary.web.minecraft-services.net/api/v1.0/download/links' \
  -H 'accept: */*' \
  -H 'accept-language: en-US,en;q=0.9,ja;q=0.8,fr-FR;q=0.7,fr;q=0.6' \
  -H 'content-type: application/json' \
  -H 'origin: https://www.minecraft.net' \
  -H 'priority: u=1, i' \
  -H 'referer: https://www.minecraft.net/' \
  -H 'sec-ch-ua: "Google Chrome";v="137", "Chromium";v="137", "Not/A)Brand";v="24"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: cross-site' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36'`
URL=`echo $DATA | jq '.result.links[] |select(.downloadType == "serverBedrockLinux").downloadUrl'|tr -d '"'`
echo -n $URL