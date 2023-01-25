# <span style="color: #F05340;">Laravel</span> + <span style="color: #0db7ed;">Docker</span> + <span style="color: #0060E0;">Traefik</span> developer environment for Windows

## Setup:
- Install WSL 2 + Ubuntu + Docker
- `$ wsl`
- `$ cd ~`
- `$ mkdir www`
- `$ cd www/`
- `$ git clone dv5150/laravel-docker-dev-env .`
- Create a PHP dockerfile for your project based on the given example in `./dockerfiles`
- Update `./docker-compose.yml` file with your project data
- Run Windows PowerShell __as admin__: `nano C:\Windows\system32\drivers\etc\hosts`
- Add your project domains to your hosts file, e.g.:
    - `127.0.0.1 projectname.test`
    - `127.0.0.1 anotherproject.test`
    - `127.0.0.1 yetanothertodolist.test`
- *(Optional) Before the last step, do the SSL setup explained below if you want to get https working*
- Finally run `$ docker-compose up -d --build`

## SSL:
- Run Windows PowerShell __as admin__
- `$ choco install mkcert`
- `$ mkcert -install`
  - Now for each project:
    - `$ cd \\wsl.localhost\Ubuntu\home\<user>\www`
    - `$ cd certs/`
    - `$ mkcert <projectname>.test`
- Update `./configuration/config.yml` file with the cert file locations from the previous step