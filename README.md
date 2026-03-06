# GPodder compatible sync server

Ref. doc: https://github.com/kd2org/opodsync/blob/main/README.md

# Setup

## Before the first run

### Configuration

Edit [`config.local.php`](./data/config.local.php) according to your needs.  
In particular, set the `TITLE` and `BASE_URL` variables.  
The `BASE_URL` can also be set in the `docker-compose.yml` file.  

The base one is taken directly from [`oPodSync` repo](https://github.com/kd2org/opodsync).  
See also the main documentation of `oPodSync`: [https://github.com/kd2org/opodsync/tree/main?tab=readme-ov-file#configuration](https://github.com/kd2org/opodsync/tree/main?tab=readme-ov-file#configuration).  

### Mounted folder permission

Change the permission of the `data` folder in the `opodsync` main folder, which is then mounted in the container:
```zsh
sudo chown 33:33 data
```

## Start the server with `docker compose`

```zsh
docker compose build
docker compose up -d
```
