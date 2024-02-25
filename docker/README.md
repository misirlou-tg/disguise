# Disguise docker

This directory contains a docker compose file that runs [nginx](https://nginx.org/en/)
to serve up the Disguise app. 

It also runs Mountebank, with nginx proxying the `/api` calls to that container.
Disguise is configured to call to Mountebank with that path in `src/app/shared/constants.ts`

## Setup
In [compose.yaml](compose.yaml) you can configure the `web` container that runs
nginx where to get the compiled version of the Angular app. You can choose from
either:
- The current compiled app in the git workspace `disguise/docs` folder
- A docker volume with the compiled app

There is a script [run-build-env.sh](../run-build-env.sh) that can be used to
compile the Angular app and create the docker volume. 

**Note:** In the currently committed version of the compiled Disguise app,
`docs/index.html` has a `<base>` element that points to the Opus Software's
GitHub Pages page. If you don't recompile the Angular app this file must be
manually modified to remove that:
```html
<base href="/">
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
