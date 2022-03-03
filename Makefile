compile-client:
	nim c -o:bin/client src/client.nim

compile-protocol:
	nim c -o:bin/protocol src/protocol.nim

compile-server:
	nim c -o:bin/server src/server.nim

run-client:
	./bin/client localhost Jasper

run-protocol:
	./bin/protocol

run-server:
	./bin/server

docker-image-client-size:
	docker inspect -f "{{.Size}}" chatty/client

docker-build-client:
	docker build -f Dockerfile.client . -t chatty/client
