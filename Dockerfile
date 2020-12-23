FROM golang:alpine AS build

WORKDIR /src/
ADD ./ /src/
RUN GOOS=linux GOARCH=amd64 go build -o /bin/simplewebserver

FROM scratch
COPY --from=build /bin/simplewebserver /bin/simplewebserver
ENTRYPOINT ["/bin/simplewebserver"]
