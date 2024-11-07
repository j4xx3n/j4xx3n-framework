#!/bin/bash

# This is a bash script to automate google dorking for
# a login page on multiple domains.

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

echo $list
echo $output

# Loop through a list of domains
while IFS= read -r domain
do
  # Google dork each domain for signup pages & output to file
  go-dork -q site:$domain inurl:"signup" | tee -a temp
  cat temp | grep -f $list | tee -a $output
  # Filter the url to stay in scope
  rm -rf temp
done < $list
