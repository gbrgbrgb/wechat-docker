<div align="center">
  <h1 style="border-bottom: none"> Wechat-Docker </h1>
</div>

<p align="center">
  <a href="https://hub.docker.com/r/gbrgb/wechat-docker" target="_blank">
    <img alt="Docker Pulls" src="https://img.shields.io/badge/docker%20image-available-green.svg">
  </a>
</p>

<div align="center">
  <a href="./README.md">
    <img alt="README in English" src="https://img.shields.io/badge/English-d9d9d9">
  </a>
  <a href="./README_CN.md">
    <img alt="简体中文" src="https://img.shields.io/badge/简体中文-d9d9d9">
  </a>
</div>

</br> </br>

Wechat-Docker 将[铜豌豆](https://www.atzlinux.com/)提供的, 与 ubuntu 系统相兼容的 UOS 版微信容器化, 并通过 noVNC 提供浏览器访问, 从而解决 IOS 系统、MacOS 系统、Windows 系统的微信使用和微信多开问题。使用流程如下:

**1. 获取镜像文件**:

```bash
docker pull gbrgb/wechat-docker:v0.1
```

在命令行运行上述命令, 获取镜像文件。

**2. 运行容器**:

```bash
docker run --name <容器名称> --rm -e VNC_PASSWORD=<密码> -p <映射至主机的端口>:6080 gbrgb/wechat-docker:v0.1
```

运行上述命令, 自定义容器名称、密码、映射端口, 启动容器。例如:

```bash
docker run --name wechat --rm -e VNC_PASSWORD=123456 -p 6080:6080 gbrgb/wechat-docker:v0.1
```

在命令行使用 Ctrl+C 即可停止并自动删除容器。

如需后台运行容器, 可使用 `-d` 参数:

```bash
docker run --name <容器名称> --rm -d -e VNC_PASSWORD=<密码> -p <映射至主机的端口>:6080 gbrgb/wechat-docker:v0.1
```

并使用 `docker stop <容器名称>` 命令停止并删除容器。

**3. 浏览器访问微信**:

在浏览器中输入 `http://localhost:6080/vnc_auto.html` 访问微信。
其中, `6080` 为 Step 2 中设置的`<映射至主机的端口>`。

输入`<VNC_PASSWORD>`密码后, 即可使用微信。通过扫描二维码进入微信, 通过输入法窗口切换输入法, 可中文输入。

**4. 微信多开**:

继续在命令行使用命令:

```bash
docker run --name <容器名称> --rm -e VNC_PASSWORD=<密码> -p <映射至主机的端口>:6080 gbrgb/wechat-docker:v0.1
```

能开启多个微信微信。`<容器名称>`和`<映射主机的端口>`不能重复。

**5. IOS 系统使用微信**:

IOS 系统不能使用 docker, 需要将 docker 容器运行在服务器或自己的主机上, 通过域名或者 IP 地址, 使用手机浏览器进行访问。

**6. ARM 架构下运行**:

镜像只支持在 amd64 架构下运行, 如需在 ARM 架构下运行 (包括苹果 M 系芯片), 需要使用 QEMU 进行模拟。

安装 QEMU 后, 使用以下命令进行配置:

```bash
docker run --privileged --rm --platform linux/arm64 tonistiigi/binfmt --install amd64
```

然后即可运行容器, 需要添加 `--platform linux/amd64` 参数:

```bash
docker run --name <容器名称> --rm -e VNC_PASSWORD=<密码> -p <映射至主机的端口>:6080 --platform linux/amd64 gbrgb/wechat-docker:v0.1
```
