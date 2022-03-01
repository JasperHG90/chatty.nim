import json
import std/logging

var logger = newConsoleLogger()

type
  Message* = object
    username*: string
    message*: string

proc parseMessage*(data: string): Message =
  let dataJson = parseJson(data)
  result.username = dataJson["username"].getStr()  ## 'result' is available by default
  result.message = dataJson["message"].getStr()

proc createMessage*(username: string, message: string): string =
  result = $(%{  ## % creates JsonNode with appropriate types, $ turns it into a string
    "username": %username,
    "message": %message
  }) & "\c\1"  ## Add end-of-message signifier.

when isMainModule:  ## Ensures that test code is hidden when this module is imported
  block:
    let data = """{"username": "John", "message": "hi-ho"}"""
    let parsed = parseMessage(data)
    doAssert parsed.username == "John"  ## DoAssert is optimized for debug, assert for release mode
    doAssert parsed.message == "hi-ho"
  block:
    let data = """foobar"""
    try:
      let parsed = parseMessage(data)
      doAssert false  ## Should never be executed
    except JsonParsingError:
      doAssert true  ## This is the expected error
    except:
      doAssert false  ## This is unexpected error
  block:
    let expected = """{"username":"dom","message":"hello"}""" & "\c\1"
    let actual = createMessage("dom", "hello")
    logger.log(lvlDebug, "Expected: " & expected)
    logger.log(lvlDebug, "Actual: " & actual)
    doAssert actual == expected
