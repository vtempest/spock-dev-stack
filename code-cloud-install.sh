#!/bin/bash

#ask domain name pointing to this server
#must have DNS entry CNAME subdomain code. 
read -p 'Domain Name: ' DOMAIN
echo "DOMAIN=$DOMAIN" > .env


#check domain matches this IP
sudo apt install -y dnsutils curl
IP=$(curl  ipinfo.io/ip)
DOMAIN_IP=$(dig +short $DOMAIN | tail -1)
if [ "$DOMAIN_IP" != "$IP" ]; then
    echo "$DOMAIN $DOMAIN_IP does not point to this server $IP"
    exit 0 
fi


#install docker compose
curl -s https://get.docker.com | bash -s --
sudo usermod -aG docker $USER
sudo apt install -y docker-compose
sudo su - $USER -c "cd $PWD ;docker-compose up -d"


