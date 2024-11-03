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
      exit 1
      ;;
  esac
done


# subdomain enumberation with single domain
if [ -n "$domain" ]; then
  echo $domain | anew $output/domain.txt
  echo $domain | httpx-toolkit -td -ip -sc -cl -server | anew $output/domain-httpx.txt
  subfinder -d $domain | httpx-toolkit -td -ip -sc -cl -server | anew $output/subdomain-httpx.txt
fi


# subdomain enumberation with multiple domains
if [ -n "$list" ]; then
  cat $list | tee -a $output/domain.txt
  cat $list | httpx-toolkit -td -ip -sc -cl -server | anew $output/domain-httpx.txt
  subfinder -dL $list | httpx-toolkit -td -ip -sc -cl -server | anew $output/subdomain-httpx.txt
fi


# directory enumeration
cat $output/subdomain-httpx.txt | cut -d ' ' -f 1,2 | grep 200 | cut -d ' ' -f 1 | anew $output/subdomain-200.txt
cat $output/subdomain-200.txt | hakrawler | anew $output/subdomain-crawl.txt
cat $output/subdomain-200.txt |  waybackurls | anew $output/subdomain-crawl.txt


# vulnerability enumeration
mkdir $output/GF
cat $output/subdomain-crawl.txt | gf lfi | anew $output/GF/lfi
cat $output/subdomain-crawl.txt | gf xss | anew $output/GF/xss
cat $output/subdomain-crawl.txt | gf idor | anew $output/GF/idor
