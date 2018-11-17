<p align="center">
	<a href="https://github.com/vijos/vj4">
		<img src="https://rawgit.com/vijos/vj4/master/.github_banner.png" alt="vj4" width="100%" align="middle" />
	</a>
</p>

<p align="center">
	Docker version of <a href="https://github.com/vijos/vj4">vj4</a>, the next generation of <a href="https://vijos.org" target="_blank">Vijos</a>.
</p>

***

## Quick Start

Start your own Vijos 4 with Docker in minutes!

```bash
git clone https://github.com/vijos/vj4-docker.git
cp .env.example .env
docker-compose up -d
```

Wait for seconds for services to be up and running, then access your own Vijos 4 with `http://<ip>:8888`!

To add a super administrator:

```bash
alias drpm="docker-compose run --rm web"
drpm vj4.model.user add -1 soha 233333 soha@lohu.info # uid username password email
drpm vj4.model.user set_superadmin -1 # uid
```
