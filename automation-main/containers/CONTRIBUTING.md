# Container Contributing for Single Tenant Engineering
The following standards are applied to achieve a scalable framework centering on a small core code but still maintaining flexibility through optional customizations and add-ons.  This code should be generally self-sufficient and document external dependencies where required.

## Container Terminology
* `Dockerfile` - (upper-case intentional) the file that describes the build process of a container, moving from top to bottom.
* `multi-stage builds` - a docker build method where a temporary container is built, then only what is required is copied to a small footprint (usually scratch) container as the final build.
* `multi-platform builds` - a docker build method where multiple architectures (arm, amd64, etc.) are built from a single Dockerfile

## Container Standards
The following are enforced standards.
* Use `hadolint` to lint Dockerfiles.
  * Resolve any errors found by hadolint.

* TBD

## Container Changelogs
* A file `CHANGELOG-SCS.md` should be included. Use syntax prescribed in the General Contributing Guide.

## Container Best Practices
Some common best practices for Dockerfiles are:
* Pin Versions as much as possible.
* Add each permanent package on a newline followed by it's dependencies for easier management.
* Do not create files not used
  * If deleting a file, make sure it's in the same Docker Layer it was created.
  * Be judicious when to chain commands and when to separate them.
* Structure Layers so that more frequently changes ones are at the bottom.
* If possible, use multi-stage builds.
* If possible, use multi-platform builds.
* Be careful using heredocs (EOF, EOT, etc.) as error return codes may be encapsulated and will not stop Docker Builds.

## Development Tips
### Local Hadolint Scanning
To scan a Dockerfile locally, use the following command:
```bash
cd [YOUR_DOCKERFILE_DIR]
docker run --rm -i hadolint/hadolint: < Dockerfile
```

### Local Trivy Scanning
To scan a Docker image locally.
1. In Docker Desktop:
    * Settings -> Advanced -> Allow the default Docker socket to be used (requires password)
    * Validate `docker.sock` is available: `ls -l /var/run/docker.sock`
2. Run the following:
```sh
export TRIVY_CACHE=~/.cache/trivy
mkdir -p $TRIVY_CACHE

docker run --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $TRIVY_CACHE:/root/.cache/ \
    aquasec/trivy image '___IMAGE_NAME___'
```
