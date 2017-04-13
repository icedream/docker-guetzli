# Guetzli Docker image

This image includes a static build of Guetzli, the perceptual JPEG encoder made by Google. The entrypoint is configured to point directly at the binary
so it is possible to use `docker run` on this image just as if you would use guetzli directly on your system.

## Available tags

All available tags are always listed [in Docker Hub](https://hub.docker.com/r/icedream/guetzli/tags), the list below explains the maintained tags:

- `latest`, `1`, `1.0.1`: Latest stable version.

## Examples

Running the encoder on an image on the host system:

    docker run --rm -it -v "$(pwd):/work" -w /work icedream/guetzli \
        example.jpg example_compressed.jpg
