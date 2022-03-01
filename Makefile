compile-client:
	nim c -o:bin/client src/client.nim

compile-protocol:
	nim c -o:bin/protocol src/protocol.nim

run-client:
	./bin/client localhost

run-protocol:
	./bin/protocol
