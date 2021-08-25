# Proxy company configurator  
This simple utility is a simple proxy configurator for a series of services:  
- bash/zsh 
- git
- npm
- snap
- docker
  
## Usage
Simply edit the "set-proxy.sh" file including in the top the url of your company proxy server.  
Then open a terminal and execute the following command:  
> source ./set-proxy.sh  

**Note: Remember to logout and re-login because some environmental variables are edited.**

## Disable Proxy
To remove all proxy configuration execute:  
> source ./unset-proxy.sh

## Extra note