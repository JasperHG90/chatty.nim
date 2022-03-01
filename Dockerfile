#FROM chrishellerappsian/docker-nim-cross:latest AS build
#
#WORKDIR /app
#
#COPY /src src
#
#RUN mkdir bin
#
#RUN nim c --cc:llvm_gcc -o:bin/client src/client.nim
#
FROM alpine

#COPY --from=build /app/bin/client /app/client

COPY /bin/client /app/client

WORKDIR app

RUN chmod +x client

CMD ["/app/client"]

#CMD ["/bin/sh", "./client"]

#ENTRYPOINT ["/bin/sh", "./client", "localhost"]

#RUN ./client
