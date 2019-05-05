# Central Authentication Service (CAS) [![License](https://img.shields.io/hexpm/l/plug.svg)](https://github.com/Jasig/cas/blob/master/LICENSE)

## Introduction

This repository hosts the [Docker](https://www.docker.com/) build configuration necessary to build a [CAS](https://github.com/apereo/cas) image. See the `Dockerfile` for more info.

## Versions

A docker image for CAS server. Images are tagged to match CAS server releases.

## Requirements

* Docker version `1.9.x` ~ `18.x`

## Configuration

### Image

* The image will be available on the host via ports `8080` and `8443`
* You must check the `Dockerfile` to ensure the right branch from the [CAS overlay project](https://github.com/apereo/cas-overlay-template) is pulled/cloned.
* Check the [CAS overlay project](https://github.com/apereo/cas-overlay-template) itself to figure out the targetted CAS release.

### SSL

* Update the `thekeystore` file with the server certificate and chain if you need access the CAS server via HTTPS. 
* The password for the keystore is `changeit`.
* The build will automatically copy the keystore file to the image. The embedded container packaged in the overlay is pre-configured to use that keystore for HTTPS requests.

```bash
keytool -genkeypair -alias cas -keyalg RSA -keypass changeit \
        -storepass changeit -keystore ./thekeystore \
        -dname "CN=cas.example.org,OU=Example,OU=Org,C=AU" \
        -ext SAN="dns:example.org,dns:localhost,ip:127.0.0.1"
```

...and add `cas.example.org` to your hosts file:

```bash
# echo '127.0.0.1 cas.example.org' >> /etc/hosts
```

Be sure to adjust the above values to match your CAS domain.

### CAS Configuration

The build will also auto-copy configuration files under the `etc/cas` directory to the corresponding locations inside the image.

## Build [![](https://badge.imagelayers.io/apereo/cas:latest.svg)](https://imagelayers.io/?images=apereo/cas:latest 'apereo cas')

**NOTE:** On windows, you may want to run `bash` first so you can execute shell scripts.

```bash
./build.sh $CasVersion
```

The image will be built as `apereo/cas:v$CasVersion`.

## Run

```bash
./run.sh $CasVersion
```

## Release

* New images shall be released at the time of a new CAS server release.
* Image versions are reflected in the `build|run.sh` files and need to be updated per CAS/Image release.
* Images are published to [https://hub.docker.com/r/apereo/cas/](https://hub.docker.com/r/apereo/cas/)

```bash
./push.sh $CasVersion
```
