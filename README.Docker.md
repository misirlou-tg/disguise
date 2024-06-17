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
By default port 8080 is exposed by the Mountebank container. In [`compose.yaml`](compose.yaml)
you can remove that and add others as necessary. Changing the exposed ports
requires restarting Mountebank, just that container can be restarted with
the command:
```bash
docker compose restart mbtest
```

## Note on running the image

To run the image the environment variable `MBTEST_URL` must be defined for nginx
to start up. `MBTEST_URL` is used to tell nginx where to proxy the calls the
Disguise app makes to Mountebank.

[`compose.yaml`](compose.yaml) defines the environment variable to point to the
`mbtest` service that it defines, so if you are using it there is nothing else
to do.

But if you use the image in another environment the `MBTEST_URL` environment variable
gives you flexibility to proxy the Mountebank calls wherever necessary.
