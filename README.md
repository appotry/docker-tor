# docker-tor

## Alpine Tor

> 这是一个匿名代理工具 Tor 的 docker 镜像，基于 alpine 制作。 支持amd64,arm64,arm v7。


### Tor 使用

启动 Tor 匿名代理

``` sh
docker run -d --name tor -p 9100:9100 bloodstar/tor
```

**默认情况下 Tor 监听在 `0.0.0.0:9100` 端口上，若想通过 Tor 代理访问网络，请将浏览器代理设置到 `socks5://TOR-DOCKER-IP:9100` 即可**


### Tor 相关设置

**该 Tor 镜像默认配置文件位于 `/etc/tor/torrc`，该文件中定义了 Tor 日志位置、代理模式、前置代理、排除节点等相关设置，一些相关选项如下:**

- ExcludeNodes: 排除不可信节点，防止 Tor 蜜罐，目前预设 `{cn},{hk},{mo}` (中国、香港、澳门)，其他国家请自行查阅
- HTTPProxy: Tor 前置 HTTP 代理，众所周知的原因国内 Tor 节点无法连接，所以如需设置前置代理请修改此项
- HTTPSProxy: Tor 前置 HTTPS 代理，作用同上
- Socks5Proxy: Tor 前置 Socks5 代理，作用同上

## docker compose 样例

```yaml
version: '3'
services:

  tor:
    container_name: tor
    image: bloodstar/tor:latest
    ports:
      - "9100:9100"
    volumes:
      - ${USERDIR}/tor/etc/:/app/etc/
      - ${USERDIR}/tor/log/notices.log:/var/log/tor/notices.log
    environment:
      - PUID=${PUID}
      - PGID=${PGID}
      - TZ=${TZ}

    restart: always

```

${USERDIR} 为tor 配置文件目录
${USERDIR}/tor/etc/torrc 中修改你自己的配置

首次启动，会在`${USERDIR}/tor/etc/`目录中生成默认配置文件torrc，和torrc.sample这两个文件
