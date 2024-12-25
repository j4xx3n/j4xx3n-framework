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
  # Make a directory for output
  mkdir -p $output/Recon
  echo $domain | anew $output/Recon/domain.txt
  echo $domain | httpx-toolkit -td -ip -sc -cl -server -ports 80,443,8080,8000,8888 -threads 200 | anew $output/Recon/domain-httpx.txt
  subfinder -d $domain | anew $output/Recon/subdomain.txt
  cat $output/Recon/subdomain.txt | httpx-toolkit -td -ip -sc -cl -server -ports 80,443,8080,8000,8888 -threads 200 | anew $output/Recon/subdomain-httpx.txt

  # directory enumeration
  cat $output/Recon/subdomain-httpx.txt | cut -d ' ' -f 1,2 | grep 200 | cut -d ' ' -f 1 | anew $output/Recon/subdomain-200.txt
  cat $output/Recon/subdomain-httpx.txt | cut -d ' ' -f 1 | hakrawler | anew $output/Recon/subdomain-crawl.txt
  cat $output/Recon/subdomain-httpx.txt | cut -d ' ' -f 1 |  waybackurls | anew $output/Recon/subdomain-crawl.txt
  cat $output/Recon/subdomain-httpx.txt | cut -d ' ' -f 1 | katana -u subdomains_alive.txt -d 5 waybackarchive,commoncrawl,alienvault -kf -jc -fx -ef woff,css,png,svg,jpg,woff2,jpeg,gif,svg | anew $output/Recon/subdomain-crawl.txt

  # vulnerable endpoint enumeration
  mkdir $output/Recon/GF
  cat $output/Recon/subdomain-crawl.txt | gf lfi | anew $output/Recon/GF/lfi # LFI enumeration
  cat $output/Recon/subdomain-crawl.txt | grep -E '.php|.asp|.aspx|.jspx|.jsp' | grep '=' | anew $output/Recon/GF/ci # command injection enumeration


fi


# subdomain enumberation with multiple domains
if [ -n "$list" ]; then
  cat $list | cut -d '.' -f 1 | while read domainLoop; do
  # Make a directory for each domain
  mkdir -p $output/$domainLoop
  mkdir -p $output/$domainLoop/Recon
  cat $list | grep $domainLoop | anew $output/$domainLoop/Recon/domain.txt
  cat $list | grep $domainLoop | httpx-toolkit -td -ip -sc -cl -server -ports 80,443,8080,8000,8888 -threads 200 | anew $output/$domainLoop/Recon/domain-httpx.txt
  cat $list | grep $domainLoop | subfinder | anew $output/$domainLoop/Recon/subdomain.txt
  cat $output/$domainLoop/Recon/subdomain.txt | httpx-toolkit -td -ip -sc -cl -server -ports 80,443,8080,8000,8888 -threads 200 | anew $output/$domainLoop/Recon/subdomain-httpx.txt
  # directory enumeration
  cat $output/$domainLoop/Recon/subdomain-httpx.txt | cut -d ' ' -f 1,2 | grep 200 | cut -d ' ' -f 1 | anew $output/$domainLoop/Recon/subdomain-200.txt
  cat $output/$domainLoop/Recon/subdomain-httpx.txt | cut -d ' ' -f 1 | hakrawler | anew $output/$domainLoop/Recon/subdomain-crawl.txt
  cat $output/$domainLoop/Recon/subdomain-httpx.txt | cut -d ' ' -f 1 |  waybackurls | anew $output/$domainLoop/Recon/subdomain-crawl.txt
  cat $output/$domainLoop/Recon/subdomain-httpx.txt | cut -d ' ' -f 1 | katana -u subdomains_alive.txt -d 5 waybackarchive,commoncrawl,alienvault -kf -jc -fx -ef woff,css,png,svg,jpg,woff2,jpeg,gif,svg | anew $output/$domainLoop/Recon/subdomain-crawl.txt
  # vulnerable endpoint enumeration
  mkdir -p $output/$domainLoop/Recon/GF
  cat $output/$domainLoop/Recon/subdomain-crawl.txt | gf lfi | anew $output/$domainLoop/Recon/GF/lfi # LFI enumeration
  cat $output/$domainLoop/Recon/subdomain-crawl.txt | grep -E '.php|.asp|.aspx|.jspx|.jsp' | grep '=' | anew $output/$domainLoop/Recon/GF/ci; done

fi

