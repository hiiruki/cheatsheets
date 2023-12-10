---
title: Podman
layout: 2017/sheet
category: Devops
updated: 2023-12-11
keywords:
  - Devops
  - Podman
  - Container
intro: |
  Simple management tool for pods, containers and images.
  Podman provides a Docker-CLI comparable command-line. Simply put: `alias docker=podman`.
  More information: <https://github.com/containers/podman/blob/main/commands-demo.md>.
---

For more information about podman, visit the [Red Hat Developer website](https://developers.redhat.com/). This cheat sheet was written by Doug Tidwell, with huge thanks to Dan Walsh and Scott McCarty.

In the following `container` is either a container name or a container ID. If `tag` is omitted in image:tag , the default value is latest.

### Finding Images

| Command           | Description                               |
| ----------------- | ----------------------------------------- |
| `podman images`              | List all local images                    |
| `podman history image:tag`       | Display information about how an image was built |
| `podman login registryURL -u username [-p password]` | Log in to a remote registry             |
| `podman pull registry/username/image:tag` | Pull an image from a remote registry             |
| `podman search searchString` | Search local cache and remote registries for images             |
| `podman logout` | Log out of the current remote registry             |

The list of registries is defined in _`/etc/containers/registries.conf`_

### Building Images

| Command         | Description                                                                              |
| --------------- | ---------------------------------------------------------------------------------------- |
| `podman build -t image:tag .`      | Build a container image from the current directory's Dockerfile or Containerfile, tagging it with the specified image name and tag.                                                  |
| `podman build -t image:tag -f Dockerfile2`  | Build a container image from the Dockerfile specified by '-f' (or default to "Dockerfile") in the current directory, tagging it with the specified image name and tag. |
| `podman tag image:tag image:tag2`      | Add an additional name to a local image |
| `podman tag image:tag registry/username/image:tag`      | Same as above, but the additional name includes a remote registry |
| `podman push registry/username/image:tag`      | Push an image to a remote registry |

### Running Containers on Images

| Command                         | Description                  |
| ------------------------------- | ---------------------------- |
| `podman run --rm -it [--name name] image:tag command`                      | Run a container based on a given image.  |

- `--rm` Remove the container after it exits
- `-it` Connect the container to the terminal
- `--name` name Give the container a name
- `image:tag` The image used to create the container
- `command` A command to run (/bin/bash for example)
- `-d` Run the container in the background
- `-p` 8080:32000 Expose container port 8080 as localhost:32000
- `-v` /var/lib/mydb:/var/lib/db Map the /var/lib/mydb directory on localhost to a volume named /var/lib/db inside the container

| Command         | Description                                         |
| --------------- | --------------------------------------------------- |
| `podman commit container newImage:tag`      | Create a new image based on the current state of a running container                           |
| `podman create [--name name] image:tag`      | Create (but don’t start) a container from an image                             |
| `podman start container` | Start an existing container from an image                      |
| `podman restart container`      | Restart an existing container                 |
| `podman wait container1 [container2… ]` | Wait on one or more containers to stop |
| `podman stop container`      | Stop a running container gracefully                 |
| `podman kill container`      | Send a signal to a running container                 |
| `podman rm [-f] container`      | Remove a container (use -f if the container is running)                 |
| `podman stats container`      | Display a live stream of a container’s resource usage                 |
| `podman inspect container`      | Return metadata (in JSON) about a running container   |

### Working with Container Processes

| Command         | Description                                         |
| --------------- | --------------------------------------------------- |
| `podman ps [--all]`      | List the running containers on the system (use --all to include non-running containers)                           |
| `podman attach container`      | Attach to a running container and view its output or control it                             |
| `podman run -d image:tag`                     | Run a container in detached mode, leaving it running in the background. |
| `podman exec container command`               | Execute a command in a running container.                    |
| `podman top container`                        | Display the running processes of a container.                |
| `podman logs [-f] container`                  | Display the logs of a container. Use `-f` to follow logs in real-time. |
| `podman pause container` / `podman unpause container` | Pause/unpause all the processes in a container.         |
| `podman port container`                       | List the port mappings from a container to localhost.        |

### Working with the Container Filesystem

| Command         | Description                                         |
| --------------- | --------------------------------------------------- |
| `podman diff container`                      | Display all the changes to a container’s filesystem.           |
| `podman cp source target`                    | Copy files and folders between a container and localhost.      |
| `podman mount container` / `podman umount container` | Mount or unmount a container’s root filesystem.           |
| `podman import tarball`                      | Import a tarball and save it as a filesystem image.            |
| `podman export [-o outputFile] container`    | Export the container’s filesystem to a tar file.               |
| `podman save [-o archiveFile] [--format docker-archive\|oci-archive]` | Save a container image to an archive file in Docker or OCI format. |
| `podman load -i archiveFile`                 | Load a saved image from docker-archive or another format.      |

### Removing Images

| Command         | Description                                         |
| --------------- | --------------------------------------------------- |
| `podman rmi [-f] image:tag`                      | Remove a local image from local cache (use -f to force removal)         |
| `podman rmi [-f] registry/username/image:tag`                      | Remove a remote image from local cache (use -f to force removal)           |

### Miscellaneous

| Command         | Description                                         |
| --------------- | --------------------------------------------------- |
| `podman version`                      | Display the Podman version.         |
| `podman info`                      | Display system-wide information.         |
| `podman system df`                      | Display the disk space used by images and containers.         |
| `podman system migrate`                      | Migrate containers from one storage driver to another.         |
| `podman system prune`                      | Remove all unused containers, images, and volumes.         |
| `podman system reset`                      | Reset podman to its initial state.         |
| `podman system connection`                      | Display the connection information for the Podman daemon.         |
| `podman system service`                      | Manage the Podman service.         |
