# This project contains all files on the Shiny-server

## URL to the shiny server:
`http://192.168.1.67:3838/{app name}/`

For examlpe:

[http://192.168.1.67:3838/boatinternational/](http://192.168.1.67:3838/boatinternational/)

## How to Use:
1. Log in to R-shiny via `docker exec` or via `ssh`
2. Files are store in: `/srv/`, not in root's home.

## Other Info:
- Docker ip of the `shiny-server`: `172.17.0.8`
- Docker ip of the `mysql`: `172.17.0.10`