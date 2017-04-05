aria2
=====

A tiny [aria2](https://aria2.github.io) Docker container.

## Configuration

To change the id of the user or group the downloaded files belongs to you'll
need to set the `ARIA2_UID` and/or `ARIA2_GID` variables. *The default value for
both are `1000`.*

Aria2 itself can be configured with the command used to run the container as
shown in this example:

```
$ docker run --rm -it erlend/aria2 --rpc-secret=long_secret_here
```

In addition you can also edit the config file at `/config/aria2.conf` (the file
is created automatically the first time you run the container).

*You can find all options in the [aria2c man
page](https://aria2.github.io/manual/en/html/aria2c.html)*

### Persistent volumes

The container is configured to keep downloads in `/downloads` and aria2's
configuration files in `/config` (including ssl certificate and private key).

Make sure you mount these directories to a persistent storage medium (most
commonly with a data volume container or to a local directory with `-v`).
