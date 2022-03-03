# Client application for chat server

import os, threadpool, asyncdispatch, asyncnet
import std/logging
import protocol

proc connect(socket: AsyncSocket, serverAddr: string) {.async.} =
  echo("Connecting to " & serverAddr)
  await socket.connect(serverAddr, 7687.Port)
  echo("Connected!")

  while true:
    let line = await socket.recvLine()
    let parsed = parseMessage(line)
    echo(parsed.username & " said " & parsed.message)

var logger = newConsoleLogger()
logger.log(lvlInfo, "Chat application started")

if paramCount() == 0:
  quit("Please specify the server address, e.g. './client localhost'")

let serverAddr = paramStr(1)
let username = paramStr(2)
logger.log(lvlInfo, "Connecting to " & serverAddr & " as user " & username)

var socket = newAsyncSocket()
asyncCheck connect(socket, serverAddr)

var messageFlowVar = spawn stdin.readLine()

while true:
  if messageFlowVar.isReady():
    let message = createMessage(username, ^messageFlowVar)
    asyncCheck socket.send(message)
    messageFlowVar = spawn stdin.readLine()

  asyncdispatch.poll()

while true:
  let message = spawn stdin.readLine()
  logger.log(lvlInfo, "Sending \"" & ^message & "\"")


