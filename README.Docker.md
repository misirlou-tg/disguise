# Disguise Docker

The [Dockerfile](Dockerfile) builds the Angular app and then builds a Docker
image based on [nginx](https://nginx.org/en/) to serve up the Disguise app.

There is also a `compose.yaml` file to run Disguise + Mountebank, with nginx proxying
the `/api` calls to Mountebank. Disguise is configured to call to Mountebank with
that path in [`constants.ts`](src/app/shared/constants.ts)

## Building the image

```bash
docker build --tag disguise:latest .
```

## Usage

### Start the application
```bash
docker compose up [-d]
```
Navigate to `http://localhost/` to see Disguise and interact with
Mountebank.

### Stop the application
```bash
docker compose down
```

### Exposing imposter ports
By default port 8080 is exposed by the Mountebank container. In [compose.yaml](compose.yaml)
you can remove that and add others as necessary. Changing the exposed ports
requires restarting Mountebank, just that container can be restarted with
the command:
```bash
docker compose restart mbtest
```
