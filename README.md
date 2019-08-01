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
cd vj4-docker
cp .env.example .env
docker-compose up -d
```

Wait for seconds for services to be up and running, then you can access your own Vijos 4 with `http://<ip>:8888`.

To add a super administrator:

```bash
alias drpm="docker-compose run --rm web"
drpm vj4.model.user add -1 soha 233333 soha@lohu.info # uid username password email
drpm vj4.model.user set_superadmin -1 # uid
```

## Judging

To enable judging, you should configure a judge account first:

```bash
alias drpm="docker-compose run --rm web"
drpm vj4.model.user add -2 judge 123456 judge@example.org # uid username password email
drpm vj4.model.user set_judge -2 # uid
```

Then download a example judge configuration file:

```bash
mkdir -p ./data/judge/ && wget -O ./data/judge/config.yaml https://raw.githubusercontent.com/vijos/jd4/master/examples/config.yaml
# fill account info of judge user you've created before in config.yaml 
nano ./data/judge/config.yaml
```

You can use `http://web:8888/` as `server_url` in `config.yaml` if the web service is listening to port in the container.

Edit `docker-compose.yml` and uncomment `judge` block and `docker-compose down && docker-compose up -d`.

Now your can judge your codes on your Vijos 4!
