function cheat () {
    old="$IFS"
    IFS='/'
    str="$*"
    curl -s cheat.sh/$str | less
}

function rndXkcdUrl () {
    newestNum=$(curl -s https://xkcd.com/info.0.json | jq .num)
    rnumber=$((1 + $RANDOM % $newestNum))
    json=$(curl -s https://xkcd.com/$rnumber/info.0.json)
    url=$(jq -r .img <<< $json)
    echo $url
}

function xkcd () {
    newestNum=$(curl -s https://xkcd.com/info.0.json | jq .num)
    rnumber=$((1 + $RANDOM % $newestNum))
    json=$(curl -s https://xkcd.com/$rnumber/info.0.json)
    url=$(jq -r .img <<< $json)
    title=$(jq -r .title <<< $json)
    alt=$(jq -r .alt <<< $json)
    transcript=$(jq -r .transcript <<< $json)
    date="$(jq -r .day <<< $json).$(jq -r .month <<< $json).$(jq -r .year <<< $json)"
    echo $url
    echo "\n\"$title\"\n"
    echo "#$rnumber -- $date\n"
    icat --align left $url || (echo $alt && echo $transcript)
}
