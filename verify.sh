#!/bin/bash

# Verify installations
echo "Verifying installations..."
commands=( "anew" "httpx" "subfinder" "hakrawler" "waybackurls" "katana" "gf" )
for cmd in "${commands[@]}"; do
  if ! command -v $cmd &> /dev/null; then
    echo "$cmd installation failed. Please check manually."
  else
    echo "$cmd installed successfully."
  fi
done