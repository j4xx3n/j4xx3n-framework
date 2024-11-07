# j4xx3n's bug bounty recon framework


## scripts
- enum.sh
- dork-signup.sh

### enum.sh
This bash script performs automated subdomain enumeration, directory crawling, and vulnerability scanning (LFI, XSS, IDOR) for one or more domains, saving the results in specified output files.

**tools**
- subfinder
- httpx
- anew
- hakrawler
- waybackurls
- urldedupe
- gf

**enviroment**
- kali linux

## dork-signup.sh
This bash script automates Google dorking for identifying signup pages across multiple domains, filtering the results based on a provided list, and saving the findings to a specified output file.

**tools**
go-dork
tee

**enviroment**
- kali linux
