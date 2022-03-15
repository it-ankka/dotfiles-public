function cheat () {
    old="$IFS"
    IFS='/'
    str="$*"
    curl -s cheat.sh/$str | less
}

function xkcd () {
    newestNum=$(curl -s https://xkcd.com/info.0.json | jq .num)
    rnumber=$((1 + $RANDOM % $newestNum))
    json=$(curl -s https://xkcd.com/$rnumber/info.0.json)
    url=$(jq -r .img <<< $json)
    echo $url
    title=$(jq -r .title <<< $json)
    echo "\n$title\n"
    icat --align left $url
}
