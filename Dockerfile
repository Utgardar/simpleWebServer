FROM golang:1.14-buster AS build

WORKDIR /src/
ADD ./ /src/

ARG TARGETPLATFORM
ARG BUILDPLATFORM

RUN CGO_ENABLED=0 GOOS=linux GOARCH=${TARGETPLATFORM} go build -o simplewebserver
RUN useradd -u 10001 scratchuser

FROM scratch
COPY --from=build /src/simplewebserver /simplewebserver
COPY --from=build /etc/passwd /etc/passwd
ENTRYPOINT ["/simplewebserver"]
