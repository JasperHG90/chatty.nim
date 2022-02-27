compile-client:
	nim c -o:bin/client src/client.nim

run-client:
	./bin/client localhost
