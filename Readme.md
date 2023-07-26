# <span style="color: #F05340;">Laravel</span> + <span style="color: #0db7ed;">Docker</span> + <span style="color: #0060E0;">Traefik</span> developer environment
## The goal of the project:
To create a Docker development environment, which is able to:
- Run multiple Laravel projects simultaneously
- Set up each project with their own PHP and Node versions
- Set a custom local test domain for each project
- Provide SSL certificate for each domain
##### `Tested on Windows 11 using Laravel 8`
---
## Setup:
- Install [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install) + [Ubuntu](https://apps.microsoft.com/store/detail/ubuntu-22041-lts/9PN20MSR04DW) + [Docker](https://www.docker.com/)
- `$ wsl`
- `$ cd ~`
- `$ git clone git@github.com:dv5150/laravel-docker-dev-env.git dev-env`
- Update `~/dev-env/docker-compose.yml` file with your project data
- Run Windows PowerShell __as admin__: `nano C:\Windows\system32\drivers\etc\hosts`
- Add your project domains to your hosts file, e.g.:
    - `127.0.0.1 projectname.test`
    - `127.0.0.1 anotherproject.test`
    - `127.0.0.1 yetanothertodolist.test`
- *(Optional) Before the last step, do the SSL setup explained below if you want to get https working*
- Now you'll be able to run as many projects as you would like to: `$ docker-compose up -d <projectname> <anotherproject> <etc...>`
- Enter the project work container as: `docker-compose exec -it <projectname> /bin/sh`
---
## SSL:
- Run Windows PowerShell __as admin__
- Install [Chocolatey](https://chocolatey.org/install) if you don't have it already.
- `$ choco install mkcert`
- `$ mkcert -install`
  - Now for each project:
    - `$ cd \\wsl.localhost\Ubuntu\home\<user>\dev-env\certs`
    - `$ mkcert <projectname>.test`
- Update `~/dev-env/traefik/config.yml` file with the cert file locations from the previous step
---
## Custom terminal commands:
- `[art]` - `php artisan`
- `[rl]` - `route:list`
- `[rlc]` - `route:list --compact`
- `[nrw]` - `npm run watch`
- `[nrp]` - `npm run production`
- `[nrd]` - `npm run development`
- `[dumpa]` - `composer dump-autoload`

Update `.ashrc` file to change these.
