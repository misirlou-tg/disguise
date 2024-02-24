# Disguise docker

This directory contains a docker compose file that runs [nginx](https://nginx.org/en/)
to serve up the committed version of the compiled Disguise app, the one in
`disguise/docs`.

It also runs Mountebank, with nginx proxying the `/api` calls to that service.
Disguise is configured to call to Mountebank with that path in `src/app/shared/constants.ts`

**Note:** In the currently committed version of the compiled Disguise app,
`docs/index.html` has a `<base>` element that points to the Opus Software's
GitHub Pages page. This must be manually modified to remove that:
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
```base
docker compose down
```

### Exposing imposter ports
By default port 8080 is exposed by the Mountebank service. In [compose.yaml](compose.yaml)
you can remove that and add others as necessary. Changing the exposed ports
requires restarting the Mountebank service, just that service can be restarted
with the command:
```bash
docker compose restart mbtest
```
