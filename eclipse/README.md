# Eclipse IDE Container

This container provides Eclipse IDE through a web-based VNC portal, similar to the SQL Workbench setup.

## Features

- Eclipse IDE (Java Development edition) 2024-12
- Web-based access through VNC portal
- OpenJDK 17 pre-installed
- Persistent workspace configuration
- Audio support
- WebGL support

## Building

```bash
docker build -t eclipse-ide:latest .
```

## Running

```bash
docker run -d \
  --name eclipse \
  -p 5800:5800 \
  -p 5900:5900 \
  -v /path/to/workspace:/export/configs/eclipse-workspace \
  eclipse-ide:latest
```

## Accessing Eclipse

- Web interface: http://localhost:5800
- VNC client: vnc://localhost:5900

## Environment Variables

- `USER_ID`: User ID to run the application (default: 1000)
- `GROUP_ID`: Group ID to run the application (default: 1000)
- `DISPLAY_WIDTH`: Width of the display (default: 1920)
- `DISPLAY_HEIGHT`: Height of the display (default: 1080)
- `ECLIPSE_CUSTOM_ARGS`: Custom arguments to pass to Eclipse
- `VNC_PASSWORD`: Password for VNC access (optional)

## Workspace Persistence

The Eclipse workspace is stored in `/export/configs/eclipse-workspace` and should be mounted as a volume for persistence across container restarts.

## Based On

- [jlesage/baseimage-gui](https://github.com/jlesage/docker-baseimage-gui) - Provides the VNC/web interface
- [Eclipse IDE](https://www.eclipse.org/) - The IDE itself
