# decsync-docker
A minimalistic, but batteries-included, up-to-date docker container for running [Decsync](https://github.com/39aldo39/DecSync) as a local CalDav server (using [Radicale](https://github.com/Kozea/Radicale)). This way, Decsync can be easily used with any calendar app supporting CalDav – e.g. Thunderbird or Gnome Calendar.

## Usage

To run the container, and have it automatically start after rebooting, just do:

```bash
docker run \
  -v <decsync-directory>:/decsync-data \
  -p 5232:5232 \
  --name decsync-caldav \
  --restart unless-stopped \  
  ghcr.io/mityax/decsync-docker:main
```

**Remember to** replace `<decsync-directory>` in the command in with the path to your local, synchronised Decsync data directory.

You can then just connect to the local CalDav server using this url: [http://localhost:5232](http://localhost:5232)

When asked for credentials, just enter something random – the server accepts everything as per the defaul configuration, which is fine as long is it is only exposed on the local network.

## Configuration
Should you want to add further server/Radicale configuration, take a look at the [base image](https://github.com/tomsquest/docker-radicale).

## A note on maintenance
While I do not plan to actively maintain this project in terms of adding new features, I will fix bugs and keep it functioning since I'm using this myself. This should not require much manual action though, since the Dockerfile is very simple and based on the upstream [tomsquest/docker-radicale](https://github.com/tomsquest/docker-radicale) image – it is not a copy but an extension thereof, with the minimal required changes to make the official [Radicale Decsync plugin](https://github.com/39aldo39/Radicale-DecSync) work. There should thus not be much room for compatibility issues in future updates of the base image, at least until Radicale v4 is released.



