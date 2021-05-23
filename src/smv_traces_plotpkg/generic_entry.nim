import hashes
import nre
import strutils


type EntryType* = enum
  nkInt,
  nkString,
  nkBool

type GenericEntry* = object
  case kind*: EntryType
  of nkInt:
    intVal*: int
  of nkString:
    stringVal*: string
  of nkBool:
    boolVal*: bool

proc hash*(entry: GenericEntry): Hash =
  case entry.kind:
    of nkInt:
      return hash(entry.intVal)
    of nkString:
      return hash(entry.stringVal)
    of nkBool:
      return hash(entry.boolVal)

proc `==`*(a: GenericEntry, b: GenericEntry): bool =
  if a.kind != b.kind:
    return false
  case a.kind:
    of nkInt:
      return a.intVal == b.intVal
    of nkString:
      return a.stringVal == b.stringVal
    of nkBool:
      return a.boolVal == b.boolVal

func getType*(a: GenericEntry): EntryType =
  return a.kind

proc getValue*(a: GenericEntry, out_data: var int): bool =
  if a.kind == nkInt:
    out_data = a.intVal
    return true
  return false

proc getValue*(a: GenericEntry, out_data: var string): bool =
  case a.kind:
    of nkString:
      out_data = a.stringVal
    of nkBool:
      out_data = $a.boolVal
    of nkInt:
      out_data = $a.intVal
  return true

proc getValue*(a: GenericEntry, out_data: var bool): bool =
  if a.kind == nkBool:
    out_data = a.boolVal
    return true
  return false

proc makeEntry*(value: int): GenericEntry =
  return GenericEntry(kind: nkInt, intVal: value)

proc makeEntry*(value: string): GenericEntry =
  return GenericEntry(kind: nkString, stringVal: value)

proc makeEntry*(value: bool): GenericEntry =
  return GenericEntry(kind: nkBool, boolVal: value)

proc id(input: string): string =
  return input


proc parseValue*(raw_value: string): GenericEntry =
  let parser_caller_pairs = (
                (re"\s*(\d+)\s*", parseInt),
                (re"(?i)\s*(true|false)\s*", parseBool),
                (re"\s*([^\s]+)\s*", id)
                  )

  for i_pair in parser_caller_pairs.fields:
    let matcher = i_pair[0]
    let parser = i_pair[1]
    let match = raw_value.find(matcher)
    if match.isSome():
      let parsed_value = parser(match.get.captures[0])
      return makeEntry(parsed_value)

  raise newException(ValueError, "Unable to parse the data: " & raw_value)


