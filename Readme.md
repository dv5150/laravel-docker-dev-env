# <span style="color: #F05340;">Laravel</span> + <span style="color: #0db7ed;">Docker</span> + <span style="color: #0060E0;">Traefik</span> developer environment for Windows

## Setup:
- Install [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install) + [Ubuntu](https://apps.microsoft.com/store/detail/ubuntu-22041-lts/9PN20MSR04DW) + [Docker](https://www.docker.com/)
- `$ wsl`
- `$ cd ~`
- `$ git clone dv5150/laravel-docker-dev-env dev-env`
- Update `~/dev-env/docker-compose.yml` file with your project data
- Run Windows PowerShell __as admin__: `nano C:\Windows\system32\drivers\etc\hosts`
- Add your project domains to your hosts file, e.g.:
    - `127.0.0.1 projectname.test`
    - `127.0.0.1 anotherproject.test`
    - `127.0.0.1 yetanothertodolist.test`
- *(Optional) Before the last step, do the SSL setup explained below if you want to get https working*
- Finally run `$ docker-compose up -d --build`

## SSL:
- Run Windows PowerShell __as admin__
- Install [Chocolatey](https://chocolatey.org/install) if you don't have it already.
- `$ choco install mkcert`
- `$ mkcert -install`
  - Now for each project:
    - `$ cd \\wsl.localhost\Ubuntu\home\<user>\dev-env\certs`
    - `$ mkcert <projectname>.test`
- Update `~/dev-env/traefik/config.yml` file with the cert file locations from the previous step