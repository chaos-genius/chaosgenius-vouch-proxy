# Chaos Genius SSO setup

## Pre-requisites

1. On the server where Chaos Genius is running, install these:
    - Docker
    - nginx
1. A (sub-)domain name to host Chaos Genius and Vouch proxy with HTTPS. The domain's A record should point to the above server.

## Setup

Clone this repository:
```
git clone https://github.com/chaos-genius/chaosgenius-vouch-proxy.git
```

### Setup vouch proxy

1. Obtain Google API client ID and client secret from here: https://console.cloud.google.com/apis/credentials
1. Open [`config/config.yml`](config/config.yml) and replace the following:
    - `TODO_YOUR_DOMAIN`: the domain name of email addresses that need to be allowed access. Anyone with an email address in this domain will be able to access Chaos Genius.
    - `TODO_CLIENT_ID` and `TODO_CLIENT_SECRET`: the credentials obtained in step 1.
    - `TODO_YOUR_SUB_DOMAIN`: the subdomain where Chaos Genius and Vouch Proxy will be set up (same as Pre-requisites step 2).
1. Change the redirect URI in the google console (found in credentials tab) to the first value in `callback_urls` (after replacing `TODO_YOUR_SUB_DOMAIN`)
1. Start vouch proxy: `./start.sh`
1. Ensure that it started successfully by checking the logs: `docker logs vouch-proxy`

### Setup nginx

1. Open [`nginx/site`](nginx/site) and replace the following:
    - `TODO_YOUR_SUB_DOMAIN`: same as pre-requisites step 2.
1. Copy `nginx/site` to `/etc/nginx/sites-available/TODO_YOUR_SUB_DOMAIN` and symlink it to `/etc/nginx/sites-enabled/TODO_YOUR_SUB_DOMAIN`
1. Setup SSL/TLS with Certbot
    - Install certbot. On Debian or Ubuntu, use `sudo apt install certbot python3-certbot-nginx`
    - Run certbot: `sudo certbot`
    - Select the correct subdomain and follow the prompts.
1. Check nginx config: `sudo nginx -t`
1. Restart nginx: `sudo systemctl restart nginx`

Visit `https://TODO_YOUR_SUB_DOMAIN`. You should see a Google sign-in prompt with only `TODO_YOUR_DOMAIN` emails allowed. Sign-in to access Chaos Genius.
