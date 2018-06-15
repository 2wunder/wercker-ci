# Docker image for Klarx CI/wercker

This docker image is used to run Wercker continues integration tests

It is based on **Ruby:2.3.3** image with:

* Headless chrome deps
* Node js
* Yarn
* Phantom JS

## Build

```bash
docker build -t klarx/wercker-ci .
```

## Push

```bash
docker push klarx/wercker-ci
```

2018 © Klarx GmbH 
