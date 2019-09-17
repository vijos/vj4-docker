<p align="center">
	<a href="https://github.com/vijos/vj4">
		<img src="https://rawgit.com/vijos/vj4/master/.github_banner.png" alt="vj4" width="100%" align="middle" />
	</a>
</p>

<p align="center">
	这是 <a href="https://github.com/vijos/vj4">vj4</a>, 下一代 <a href="https://vijos.org" target="_blank">Vijos</a> 的 Docker 版本。
</p>

***

## 快速入门

只需要花几分钟时间执行下面的命令即可运行起你自己的 Vijos！

```bash
git clone https://github.com/vijos/vj4-docker.git
cd vj4-docker
cp .env.example .env
docker-compose up -d
```

给点时间等待所有服务启动，然后你就可以使用 `http://<ip>:8888` 来访问你的 Vijos 4 了。

如果需要增加一个用户并且设置为超级管理员，请使用下列命令：

```bash
alias drpm="docker-compose run --rm web"
drpm vj4.model.user add -1 soha 233333 soha@lohu.info # 顺序为 uid username password email，创建用户，你也可以使用网页注册
drpm vj4.model.user set_superadmin -1 # -1 是 uid，将 -1 设置为管理员
```

## 评测功能

要使用评测功能，你首先应该创建一个评测机使用的用户：

```bash
alias drpm="docker-compose run --rm web"
drpm vj4.model.user add -2 judge 123456 judge@example.org # 顺序为 uid username password email，创建用户，你也可以使用网页注册
drpm vj4.model.user set_judge -2 # -2 是 uid，将 -2 设置为评测用户
```

然后你需要下载一份评测机的配置文件模板：

```bash
mkdir -p ./data/judge/ && wget -O ./data/judge/config.yaml https://raw.githubusercontent.com/vijos/jd4/master/examples/config.yaml
nano ./data/judge/config.yaml
```

在其中填入你刚刚创建的评测用户的登录信息即可。

如果你使用上文提到的 `docker-compose` 来启动服务，那么在配置文件中的 `server_url`，你可以填入 `http://web:8888/`。随后在 `docker-compose.yml` 中将 `judge` 部分的代码取消注释并保存。再次执行 `docker-compose up -d` 即可正常评测程序。
