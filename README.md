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

### Setting up Automatic Updates (optional)
To keep the container automatically up to date (using watchtower), use:

```bash
docker run -d --name watchtower-decsync \
    -v /var/run/docker.sock:/var/run/docker.sock \
    containrrr/watchtower decsync-caldav
```

Since Decsync has seen little changes in years however, and is basically only kept in a working state, it should be perfectly fine to not setup auto updates if you just want to have a stable, working setup.

## Advanced Configuration
Should you want to add further server/Radicale configuration, take a look at the [base image](https://github.com/tomsquest/docker-radicale).

## A note on maintenance
While I do not plan to actively maintain this project in terms of adding new features, I will fix bugs and keep it functioning since I'm using this myself. This should not require much manual action though, since the Dockerfile is very simple and based on the upstream [tomsquest/docker-radicale](https://github.com/tomsquest/docker-radicale) image – it is not a copy but an extension thereof, with the minimal required changes to make the official [Radicale Decsync plugin](https://github.com/39aldo39/Radicale-DecSync) work. There should thus not be much room for compatibility issues in future updates of the base image, at least until Radicale v4 is released.



