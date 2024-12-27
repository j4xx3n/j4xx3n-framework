sudo apt update && sudo apt upgrade -y
sudo apt install -y git curl wget python3 python3-pip golang
go install -v github.com/tomnomnom/anew@latest
sudo mv ~/go/bin/anew /usr/bin
sudo apt install httpx-toolkit
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
sudo mv ~/go/bin/subfinder /usr/bin
go install github.com/hakluke/hakrawler@latest
sudo mv ~/go/bin/hakrawler /usr/bin
go install github.com/tomnomnom/waybackurls@latest
sudo mv ~/go/bin/waybackurls /usr/bin
go install github.com/projectdiscovery/katana/cmd/katana@latest
sudo mv ~/go/bin/katana /usr/bin
go install github.com/tomnomnom/gf@latest
sudo mv gf ~/go/bin//usr/bin
mkdir -p ~/.gf
#git clone https://github.com/Sherlock297/gf_patterns.git
mv gf_patterns/*.json ~/.gf
rm -rf gf_patterns
sudo apt install cmake -y
#git clone https://github.com/ameenmaali/urldedupe.git
cd urldedupe
cmake CMakeLists.txt
make
sudo cp urldedupe /usr/bin

# Verify installations
echo "=========================="
echo "Verifying installations..."
commands=( "anew" "httpx" "subfinder" "hakrawler" "waybackurls" "katana" "gf" "urldedupe" )
for cmd in "${commands[@]}"; do
  if ! command -v $cmd &> /dev/null; then
    echo "$cmd installation failed. Please check manually."
  else
    echo "$cmd installed successfully."
  fi
done
