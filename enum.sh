#!/bin/bash

domain=""
list=""
output=""

while getopts "d:l:o:" opt; do
  case $opt in
    d)
      domain=$OPTARG
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
      echo "Domain: $0 -d <domain> -o <output>"
      echo "List: $0 -l <list> -o <output>"
      echo "Set the program directory as the output"
      echo "Set the list of domains as the list or single domain as domain."
      exit 1
      ;;
  esac
done


# subdomain enumberation with single domain
if [ -n "$domain" ]; then
  echo $domain | anew $output/domain.txt
  echo $domain | httpx-toolkit -td -ip -sc -cl -server | anew $output/domain-httpx.txt
  subfinder -d $domain | anew $output/subdomain.txt
  cat $output/subdomain.txt | httpx-toolkit -td -ip -sc -cl -server |anew $output/subdomain-httpx.txt
fi


# subdomain enumberation with multiple domains
if [ -n "$list" ]; then
  cat $list | tee -a $output/domain.txt
  cat $list | httpx-toolkit -td -ip -sc -cl -server | anew $output/domain-httpx.txt
  subfinder -dL $list | anew $output/subdomain.txt
  cat $output/subdomain.txt | httpx-toolkit -td -ip -sc -cl -server | anew $output/subdomain-httpx.txt
fi

# directory enumeration
cat $output/subdomain-httpx.txt | cut -d ' ' -f 1,2 | grep 200 | cut -d ' ' -f 1 | anew $output/subdomain-200.txt
cat $output/subdomain-httpx.txt | cut -d ' ' -f 1 | hakrawler | anew $output/subdomain-crawl.txt
cat $output/subdomain-httpx.txt | cut -d ' ' -f 1 |  waybackurls | anew $output/subdomain-crawl.txt

# vulnerability enumeration
mkdir $output/GF
cat $output/subdomain-crawl.txt | gf lfi | anew $output/GF/lfi
cat $output/subdomain-crawl.txt | gf xss | anew $output/GF/xss
cat $output/subdomain-crawl.txt | gf idor | anew $output/GF/idor
