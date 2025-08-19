# decsync-docker
A minimalistic, but batteries-included, up-to-date docker image for running [Decsync](https://github.com/39aldo39/DecSync) as a local CalDav server – with one command. This way, Decsync can be easily used with any calendar app supporting CalDav – e.g. Thunderbird or Gnome Calendar.

This container runs [Radicale](https://github.com/Kozea/Radicale) with the official [Radicale Decsync plugin](https://github.com/39aldo39/Radicale-DecSync) internally.

## Quickstart

To run the container, and have it automatically start after rebooting, just do:

```bash
docker run -d -p 5232:5232 --name decsync-caldav \
    -v </path/to/decsync-data>:/decsync-data \
    ghcr.io/mityax/decsync-docker:main
```

**Remember to** replace `</path/to/decsync-data>` in the command with the path to your local, synchronized Decsync data directory.

You can then just connect to the local CalDav server using this url: [http://localhost:5232](http://localhost:5232)

When asked for credentials, just enter something random – the server accepts everything as per the default configuration, which is fine as long is it is only exposed locally.


<details>
<summary><h3>Using Podman?</h3></summary>

The best way to setup this image using Podman is to create a quadlet:

1. Create `~/.config/containers/systemd/decsync-caldav.container` and paste:
   ```
   [Unit]
   Description=Decsync-Caldav Server
   
   [Container]
   ContainerName=decsync-caldav
   Image=ghcr.io/mityax/decsync-docker:main
   AutoUpdate=registry
    
   HealthCmd=curl http://localhost:5232
   
   PublishPort=5232:5232

   # Here, replace <decsync-data-dir> with the path to your synchronized data 
   # directory (tip: use "%h" as placeholder for the home directory, e.g. "%h/.decsync-data"):
   Volume=<decsync-data-dir>:/decsync-data:z
    
   [Service]
   Restart=always
   TimeoutStartSec=300
    
   [Install]
   WantedBy=default.target
   ```
2. Make systemd aware of your quadlet: `systemctl --user daemon-reload`
3. Start your quadlet: `systemctl --user start decsync-caldav`
</details>

## Advanced Configuration
Should you want to add further server/Radicale configuration, take a look at the [base image](https://github.com/tomsquest/docker-radicale).

## A note on maintenance
While I do not plan to actively maintain this project in terms of adding new features, I will fix bugs and keep it functioning since I'm using this myself. This should not require much manual action though, since the Dockerfile is very simple and based on the upstream [tomsquest/docker-radicale](https://github.com/tomsquest/docker-radicale) image – it is not a copy but an extension thereof, with the minimal required changes to make the official [Radicale Decsync plugin](https://github.com/39aldo39/Radicale-DecSync) work. There should thus not be much room for compatibility issues in future updates of the base image, at least until Radicale v4 is released.



