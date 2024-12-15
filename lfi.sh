#!/bin/bash

list=""
output=""

while getopts "l:o:" opt; do
  case $opt in
    l)
      list=$OPTARG
      ;;
    o)
      output=$OPTARG
      ;;
    *)
      echo "Usage"
      echo "====="
      echo "List: $0 -l <list> -o <output>"
      exit 1
      ;;
  esac
done


# Clean list with urldedupe
cat $list | urldedupe > $output/lfiCleanList.txt



# Scan list with nuclei using lfi tags
nuclei -l $output/lfiCleanList.txt -tags lfi


# Replace the value of each query with the word FUZZ
sed -E '
    /([Ff]ile=|[Dd]ocument=|[Ff]older=|[Rr]oot=|[Pp]ath=|[Pp]g=|[Ss]tyle=|[Pp]df=|[Tt]emplate=|[Pp]hp_path=|[Dd]oc=|[Pp]age=|[Nn]ame=|[Cc]at=|[Dd]ir=|[Aa]ction=|[Bb]oard=|[Dd]ate=|[Dd]etail=|[Dd]ownload=|[Pp]refix=|[Ii]nclude=|[Ii]nc=|[Ll]locate=|[Ss]how=|[Ss]ite=|[Tt]ype=|[Vv]iew=|[Cc]ontent=|[Ll]ayout=|[Mm]od=|[Cc]onf=|[Uu]rl=)/ {
        s/([Ff]ile=|[Dd]ocument=|[Ff]older=|[Rr]oot=|[Pp]ath=|[Pp]g=|[Ss]tyle=|[Pp]df=|[Tt]emplate=|[Pp]hp_path=|[Dd]oc=|[Pp]age=|[Nn]ame=|[Cc]at=|[Dd]ir=|[Aa]ction=|[Bb]oard=|[Dd]ate=|[Dd]etail=|[Dd]ownload=|[Pp]refix=|[Ii]nclude=|[Ii]nc=|[Ll]locate=|[Ss]how=|[Ss]ite=|[Tt]ype=|[Vv]iew=|[Cc]ontent=|[Ll]ayout=|[Mm]od=|[Cc]onf=|[Uu]rl=)[^&]*/\1FUZZ/
    }
' "$output/lfiCleanList.txt" >> "$output/lfiFuzzList.txt"



# Fuzz cleaned lists with ffuf using a list of lfi payloads
cat $output/lfiFuzzList.txt | while read url; do ffuf -u $url -mr "root:x" -w "Info/Lists/LFI-Jhaddix.txt"; done

