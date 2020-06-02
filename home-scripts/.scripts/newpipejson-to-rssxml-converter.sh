#!/bin/sh

cat "$1" | jq . | grep -E "(url|name)" | sed ':a;N;$!ba;s/\,\n/ /g' | sed "s/\"url\"\: /\<outline htmlUrl\=/g" | sed "s/      //g" | sed "s/\"name\"\: /text\=/g" | sed "s/\"$/\" type\=\"rss\"\/\>/g" | sed '1s/^/\<opml version\=\"2\.0\"\>\n\<body\>\n\<outline text\=\"Subscriptions\" title\=\"Subscriptions\"\>\n/' | sed 's/UC......................" /&xmlUrl\=\"https\:\/\/www\.youtube\.com\/feeds\/videos\.xml\?channel\_id\=&/' ; printf "</outline>\n</body>\n</opml>"
