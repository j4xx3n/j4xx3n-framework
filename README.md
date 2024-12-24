# j4xx3n's bug bounty recon framework

## enum.sh
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

Information,Location
Root of all information,BugBounty
Root for each program ,BugBounty/Example
Root for each domain , BugBounty/Example/Domain
Root for recon information,BugBounty/Example/Domain/Recon
Domain list,BugBounty/Example/Recon/Domain/domain.txt
Domain list httpx scan,BugBounty/Example/Recon/Domain/domain-httpx.txt
Subdomain list,BugBounty/Example/Recon/Domain/subdomain.txt
Subdomain list httpx scan,BugBounty/Example/Recon/Domain/subdomain-httpx.txt
Subdomains w/ 200 status code,BugBounty/Example/Recon/Domain/subdomain-200.txt
Directory crawl for all subdomains,BugBounty/Example/Recon/Domain/subdomain-crawl.txt
Root for GF recon,BugBounty/Example/Domain/Recon/GF
Url's related to IDORs,BugBounty/Example/Domain/Recon/GF/idor
Url's related to XSS,BugBounty/Example/Domain/Recon/GF/xss
Url's related to LFI,BugBounty/Example/Domain/Recon/GF/lfi
