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

Wechat-Docker containerizes the UOS version of Wechat provided by [Tong Wan Dou](https://www.atzlinux.com/), which is compatible with the Ubuntu system, and provides browser access through noVNC. This solves the problem of using Wechat and multiple Wechats on iOS, macOS, and Windows systems. The usage process is as follows:

**1. Get the image file**:

```bash
docker pull gbrgb/wechat-docker:v0.1
```

Run the above command in the command line to get the image file.

**2. Run the container**:

```bash
docker run --name <container_name> --rm -e VNC_PASSWORD=<password> -p <port_mapped_to_host>:6080 gbrgb/wechat-docker:v0.1
```

Run the above command, customize the container name, password, and mapped port to start the container. For example:

```bash
docker run --name wechat --rm -e VNC_PASSWORD=123456 -p 6080:6080 gbrgb/wechat-docker:v0.1
```

Use Ctrl+C on the command line to stop and automatically delete the container.

If you need to run the container in the background, use the `-d` parameter:

```bash
docker run --name <container_name> --rm -d -e VNC_PASSWORD=<password> -p <port_mapped_to_host>:6080 gbrgb/wechat-docker:v0.1
```

And use the `docker stop <container_name>` command to stop and delete the container.

**3. Access Wechat via browser**:

Enter `http://localhost:6080/vnc_auto.html` in the browser to access Wechat.
Where `6080` is the `<port_mapped_to_host>` set in Step 2.

After entering the `<VNC_PASSWORD>`, you can use Wechat. Scan the QR code to log in to Wechat, and switch the input method in the input method window to input Chinese.

**4. Multiple Wechat instances**:

Continue to use the command-line command:

```bash
docker run --name <container_name> --rm -e VNC_PASSWORD=<password> -p <port_mapped_to_host>:6080 gbrgb/wechat-docker:v0.1
```

You can open multiple instances of WeChat. `<container_name>` and `<port_mapped_to_host>` must not be duplicated.

**5. Using Wechat on iOS**:

iOS systems cannot use Docker, so you need to run the Docker container on a server or your host and access it through a domain name or IP address using a mobile browser.

Here's the English translation of the provided text:

**6. Running on ARM Architecture**:

The image only supports running on amd64 architecture. To run on ARM architecture (including Apple M series chips), you need to use QEMU for emulation.

After installing QEMU, use the following command for configuration:

```bash
docker run --privileged --rm --platform linux/arm64 tonistiigi/binfmt --install amd64
```

Then you can run the container by adding the `--platform linux/amd64` parameter:

```bash
docker run --name <container_name> --rm -e VNC_PASSWORD=<password> -p <host_mapped_port>:6080 --platform linux/amd64 gbrgb/wechat-docker:v0.1
```
