#!/bin/bash

list=""
output=""
unix=false
windows=flase

while getopts "l:o:uw" opt; do
  case $opt in
    u)
      unix=true
      ;;
    w)
      windows=true
      ;;
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


cat $list | urldedupe | grep -E "\.php|\.asp|\.aspx|\.jsp" | grep ? | qsreplace FUZZ | grep FUZZ > $output/ciFuzz.lst

cat $output/ciFuzz.lst 


if [ "$unix" == "true" ]; then
  echo "UNix seleected: $list test"
fi


if [ "$windows" == "true" ]; then
  echo "Windows selected: : $list test"
fi



