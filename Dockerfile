FROM golang:alpine AS build

WORKDIR /src/
ADD ./ /src/
RUN CGO_ENABLED=0 go build -o /bin/simplewebserver

FROM scratch
COPY --from=build /bin/simplewebserver /bin/simplewebserver
ENTRYPOINT ["/bin/simplewebserver"]
