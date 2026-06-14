# pymol-docker

A lightweight Docker wrapper for running PyMOL with X11/Wayland display forwarding.

## Quick start

1. Place your `license.lic` file next to `docker-compose.yml`.
2. Run:

```sh
docker compose up
```

3. Open PyMOL in the container window.

## Notes

- The container mounts the current repository into `/workspace`.
- Display forwarding uses `DISPLAY`, `WAYLAND_DISPLAY`, and `XDG_RUNTIME_DIR` from the host.
- The license file is mounted read-only into `/home/pymol/.pymol/license.lic`.

## Build or run manually

If you want to build locally:

```sh
docker build -t pymol-docker .
```

Then run:

```sh
docker run --rm -it \
  -e DISPLAY="$DISPLAY" \
  -e WAYLAND_DISPLAY="$WAYLAND_DISPLAY" \
  -e XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v "$XDG_RUNTIME_DIR":"$XDG_RUNTIME_DIR" \
  -v "$PWD":/workspace \
  -v "$PWD"/license.lic:/home/pymol/.pymol/license.lic:ro \
  pymol-docker
```
