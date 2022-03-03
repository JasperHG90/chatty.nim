FROM chrishellerappsian/docker-nim-cross:latest AS build

WORKDIR /app

COPY /src src

RUN mkdir bin

RUN nim c -o:bin/client src/client.nim

FROM alpine

COPY --from=build /app/bin/client /app/client

## See https://stackoverflow.com/questions/66963068/docker-alpine-executable-binary-not-found-even-if-in-path
RUN apk add libc6-compat

WORKDIR app

RUN chmod +x client

CMD ["./client"]
