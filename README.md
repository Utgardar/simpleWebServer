# Simple web server

## Requirements

* kubectl
* helm version 3

Required packages could be installed in MacOS with brew:

```shell
brew install kubectl helm
```

## Prerequisites

* To have properly configured domain, `values.yaml` in helm chart needs to be updated: `helm/simplewebserver/values.yaml`
* It's expected to have k8s cluster running.

## How to run environment

To start setup it's enough to run next command:

```shell
./manage.sh start
```

To stop you need to run next command:

```shell
./manage.sh stop
```
