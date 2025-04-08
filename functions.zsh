function cheat () {
    old="$IFS"
    IFS='/'
    str="$*"
    curl -s cheat.sh/$str
}

function cheatsheet () {
    cat ~/cheatsheets/$1
}

function kb () {
    explorer.exe https://kaboomjs.com/#$1
}

function rndXkcdUrl () {
    newestNum=$(curl -s https://xkcd.com/info.0.json | jq .num)
    rnumber=$((1 + $RANDOM % $newestNum))
    json=$(curl -s https://xkcd.com/$rnumber/info.0.json)
    url=$(jq -r .img <<< $json)
    echo $url
}

# XKCD
# Add this to your .bashrc or if you are using oh-my-zsh add a functions.zsh file under your oh-my-zsh/custom folder.

# Requirements:
# - Kitty terminal
# - jq
# - ImageMagick

function xkcd () {
    comicNum=$1
    newestJson=$(curl -s https://xkcd.com/info.0.json)
    newestNum=$(jq -r .num <<< $newestJson)

    if [[ "$1" != "newest" ]] ; then
        re='^[0-9]+$'
        # Check if argument is not "new", not a number or otherwise not valid and select random comic
        if ! [[ $1 =~ $re ]] || [[ comicNum -lt 1 ]] || [[ "$comicNum" -gt "$newestNum" ]] ; then
            # Generate a random comic number if none is specified
            comicNum=$((1 + $RANDOM % $newestNum))
        fi

        # Get xkcd by number
        json=$(curl -s https://xkcd.com/$comicNum/info.0.json)
    else
        # Use newest
        comicNum=$newestNum
        json=$newestJson
    fi
    

    # Parse response using jq
    url=$(jq -r .img <<< $json)
    title=$(jq -r .title <<< $json)
    alt=$(jq -r .alt <<< $json)
    transcript=$(jq -r .transcript <<< $json)
    date="$(jq -r .day <<< $json).$(jq -r .month <<< $json).$(jq -r .year <<< $json)"
    
    echo $url
    echo "\n\"$title\"\n"
    echo "#$comicNum -- $date\n"
    
    # Display the image using icat or alternatively print the alt-text and transcript of the comic
    kitty +kitten icat --align left $url || echo $transcript
    echo "\n\"$alt\"\n"
}

function xmlgetnext () {
    local IFS='>'
    read -d '<' TAG VALUE
}

# DILBERT
# Add this to your .bashrc or if you are using oh-my-zsh add a functions.zsh file under your oh-my-zsh/custom folder.

# Requirements:
# - Kitty terminal
# - ripgrep
# - ImageMagick

function dilbert () {
    officialUrl=https://dilbert.com
    url=""
    data=""
    comicNum=0
    pageNum=1
    
    # SPECIFIC COMIC
    if [[ "$1" =~ '[0-9-]{10}' ]] ; then 
        url=$(curl -s $officialUrl/strip/$1 | rg -oP 'src="\Khttps://assets.amuniversal.com[^"]+')

        if [[ -z $url ]] ; then
            echo "Comic not found"
            return
        fi

        echo "\nDilbert -- $1\n"
        kitty +kitten icat --align left $url
        return
    fi

    # QUERY
    if [[ "$1" == "-q" ]] ; then 
        data=$(curl -s "$officialUrl/search_results?sort=date_desc&terms=$2")
        pages=($(echo $data | rg -oP 'page=\K[^&]*'))
        lastPage=${pages[-2]}
        if ! [[ -z "$lastPage" ]] && [[ "$3" != "newest" ]] ; then
            pageNum=$((1 + $RANDOM % lastPage))
        fi
        data=$(curl -s "$officialUrl/search_results?sort=date_desc&terms=$2&page=$pageNum")
    # RANDOM
    else
        if [[ "$1" != "newest" ]] ; then
            pageNum=$((1 + $RANDOM % 100))
        fi
        data=$(curl -s "$officialUrl/search_results?sort=date_desc&terms=+&page=$pageNum")
    fi

    #Arrays of image urls and dates
    srcs=($(echo $data | rg -oP 'src="\Khttps://assets.amuniversal.com[^"]+'))
    dates=($(echo $data | rg -oP 'comic-title-link" href="https://dilbert.com/strip/\K[^"]+'))

    len=${#srcs[@]}

    if [[ len -lt 1 ]] ; then
        echo "No comics found"
        return
    fi
    
    # Random comic number
    comicNum=$((1 + $RANDOM % $len))

    #Select first comic
    if [[ comicNumb -eq 0 ]] || [[ len -eq 1 ]] || [[ "$1" == "newest" ]] || [[ "$3" == "newest" ]] ; then
        date=${dates[@]:0:1}
        url=${srcs[@]:0:1}
    else
        # Select random comic from page
        date=${dates[$comicNum]}
        url=${srcs[$comicNum]}
    fi

    # Display the image using icat or alternatively print the alt-text and transcript of the comic
    echo "\nDilbert -- $date\n"
    kitty +kitten icat --align left $url
    echo
}

function reddit() {
    url=https://www.reddit.com/r/$1/$2.json
    json=$(curl -sA 'Kitty zsh script' $url)
    posts=$(jq -r '.data.children' <<< $json)
    postsCount=$(jq -r '. | length' <<< $posts)
    postNum=0
    while [[ "$postNum" -lt "$postsCount" ]]
    do
        post=$(jq -r ".data.children | .[$postNum]" <<< $json)
        hint=$(jq -r '.data.post_hint' <<< $post)
        if [[ "$hint" == "image" ]] ; then
            imgUrl=$(jq -r '.data.url' <<< $post)
            kitty +kitten icat --align left $imgUrl
            return
        fi
        postNum=$((postNum + 1))
    done
}

function proj() {
    projPath=$(fzf <<< $(find ~/Projects -type d -exec test -e '{}/.git' ';' -print -prune))
    if [[ "$projPath" ]] ; then
      cd $projPath
    fi
}

function transfer() { 
  if [ $# -eq 0 ];
  then echo "No arguments specified.\nUsage:\n  transfer <file|directory>\n  ... | transfer <file_name>">&2;return 1;fi;if tty -s;then file="$1";file_name=$(basename "$file");if [ ! -e "$file" ];then echo "$file: No such file or directory">&2;return 1;fi;if [ -d "$file" ];then file_name="$file_name.zip" ,;(cd "$file"&&zip -r -q - .)|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null,;else cat "$file"|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;else file_name=$1;curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;}

function qrcode() {
    curl qrenco.de/"$@"
}

function weather() {
  clear; 
  curl wttr.in/$1;
}

function findCaptivePortal() {
  interfaceName=$1
  if [[ -z $1 ]]; then
    interfaceName=$(ip -j link show | jq -r '.[1].ifname') 
    echo "No network interface specified. Using default interface: $interfaceName\n"
  fi
  portalIp=$(route -n | grep --color=none "^0.0.0.0.*$1" | awk '{ print $2; }' )
  if [[ -n $portalIp ]]; then 
    echo "Captive portal IP found: \n$portalIp"
  else 
    echo "ERROR: No captive portal IP found."
  fi

}
