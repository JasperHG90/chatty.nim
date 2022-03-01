# Client application for chat server

import os, threadpool
import std/logging

var logger = newConsoleLogger()
logger.log(lvlInfo, "Chat application started")

if paramCount() == 0:
  quit("Please specify the server address, e.g. './client localhost'")

let serverAddr = paramStr(1)
logger.log(lvlInfo, "Connecting to " & serverAddr)

while true:
  let message = spawn stdin.readLine()
  logger.log(lvlInfo, "Sending \"" & ^message & "\"")
