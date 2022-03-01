compile-client:
	nim c -o:bin/client src/client.nim

compile-protocol:
	nim c -o:bin/protocol src/protocol.nim

compile-server:
	nim c -o:bin/server src/server.nim

run-client:
	./bin/client localhost

run-protocol:
	./bin/protocol

run-server:
	./bin/server
