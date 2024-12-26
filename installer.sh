sudo apt update && sudo apt upgrade -y
sudo apt install -y git curl wget python3 python3-pip golang
go install -v github.com/tomnomnom/anew@latest
sudo mv anew /usr/bin
sudo apt install httpx-toolkit
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
sudo mv subfinder /usr/bin
go install github.com/hakluke/hakrawler@latest
sudo mv hakrawler /usr/bin
go install github.com/tomnomnom/waybackurls@latest
sudo mv waybackurls /usr/bin
go install github.com/projectdiscovery/katana/cmd/katana@latest
sudo mv katana /usrm -rf gf_patternsr/bin
go install github.com/tomnomnom/gf@latest
sudo mv gf /usr/bin
mkdir -p ~/.gf
git clone https://github.com/Sherlock297/gf_patterns.git
mv gf_patterns/*.json ~/.gf
rm -rf gf_patterns


# Verify installations
echo "=========================="
echo "Verifying installations..."
commands=( "anew" "httpx" "subfinder" "hakrawler" "waybackurls" "katana" "gf" )
for cmd in "${commands[@]}"; do
  if ! command -v $cmd &> /dev/null; then
    echo "$cmd installation failed. Please check manually."
  else
    echo "$cmd installed successfully."
  fi
done