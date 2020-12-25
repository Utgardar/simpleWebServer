# Simple web server

## Requirements

* kubectl
* helm version 3

Required packages could be installed in MacOS with brew:

```shell
brew install kubectl helm
```

For local run you will need `multipass` to be installed. Ansible playbook is written for ubuntu. To install multipass in ubuntu you need to run:

```shell
brew cask install multipass
```

## Prerequisites

* To have properly configured domain, `values.yaml` in helm chart needs to be updated: `helm/simplewebserver/values.yaml`
* It's expected to have k8s cluster running.

## HOWTO section

### How to run application localy

To start virtual machine with Docker, NGINX and this application, you need to run:

```shell
./manage.sh start
```

Script will start virtual machine and configure everything to run application.

To stop you need to run next command:

```shell
./manage.sh stop
```

After this step machine will be removed from your environment.

### How to run helm chart

To start setup it's enough to run next command:

```shell
./manage.sh start-k8s
```

To stop you need to run next command:

```shell
./manage.sh stop-k8s
```

## Additional parameters for application

```shell
> simpleserver --help

Webserver which returns a simple answer

Usage:
  typeform [flags]

Flags:
      --debug         Enable for GIN
  -h, --help          help for typeform
      --port string   Web server port (default "8765")
```
