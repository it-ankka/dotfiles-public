function cheat () {
    old="$IFS"
    IFS='/'
    str="$*"
    curl -s cheat.sh/$str | less
}
