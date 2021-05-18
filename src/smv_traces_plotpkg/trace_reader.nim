import streams
import strutils
import nre
import system
import tables 
import hashes

type EntryType* = enum 
    nkInt, 
    nkString,
    nkBool

type GenericEntry = object 
  case kind*: EntryType
  of nkInt: 
    intVal: int
  of nkString:
    stringVal: string
  of nkBool:
    boolVal: bool 

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

proc getValue*[T](a: GenericEntry): T = 
  case a.kind:
    of nkInt:
      return a.intVal
    of nkString:
      return a.stringVal
    of nkBool:
      return a.boolVal

proc makeEntry*(value: int) : GenericEntry =
  return GenericEntry(kind: nkInt, intVal: value) 

proc makeEntry*(value: string) : GenericEntry =
  return GenericEntry(kind: nkString, stringVal: value) 

proc makeEntry*(value: bool) : GenericEntry =
  return GenericEntry(kind: nkBool, boolVal: value) 


const iteration_line_matcher_string = "\\s*-> State:\\s+(\\d+)\\.(\\d+)\\s<-"

func getGroups(instring: string, group_idx_to_parse: int) : int = 
  let matcher = re(iteration_line_matcher_string)
  let match = instring.find(matcher)
  if match.isSome():
    return match.get.captures[group_idx_to_parse].parseInt()
  else:
    raise newException(IOError, "Unable to parse the given string: " & instring) 


func getIterationNumber*(instring: string) : int =
  return getGroups(instring, 1)

func getTraceNumber*(instring: string) : int =
  return getGroups(instring, 0)

func isIterationLine*(instring: string) : bool = 
  let local_matcher = re(iteration_line_matcher_string)
  return instring.find(local_matcher).isSome()

proc getNumberOfSteps*(instream : Stream) : int = 
  var line : string 
  return 2


proc getDataChunk*(instream: string): Table[string, GenericEntry] = 
  var line = ""
  var strm = newStringStream(instream)
  let parser = re"([^\s]+)\s*=\s*([^\s]+)"
  var temp_data = initTable[string, GenericEntry]()
  while strm.readLine(line):
    echo "line: " & line
    let match = line.find(parser)
    if match.isSome():
      let variable_name = match.get.captures[0]
      let value = match.get.captures[1]
      temp_data[variable_name] = makeEntry(0)
    else:
      echo "No variable found"
  return temp_data


proc parseValue*(raw_value: string): GenericEntry = 
  let parsable_value = raw_value.toLowerAscii()
  let parser_caller_pairs = (
                (re"\s*(\d+)\s*", parseInt), 
                (re"\s*(true|false)\s*", parseBool)
                )

  for i_pair in parser_caller_pairs.fields: 
    let parser = i_pair[0]
    let caller = i_pair[1] 
    let match = parsable_value.find(parser)
    if match.isSome():
      let parsed_value = caller(match.get.captures[0])
      return makeEntry(parsed_value)

  raise newException(ValueError, "Unable to parse the data: " & raw_value)



proc getDataChunk*(trace_index: int, step_index: int, instream: string) : Table[string, GenericEntry] = 
  var strm = newStringStream(instream)
  var line = ""
  while strm.readLine(line):
    if isIterationLine(line):
      let actual_step_index = getIterationNumber(line)
      let actual_trace_index = getTraceNumber(line)
      if step_index == actual_step_index and 
        trace_index == actual_trace_index:
        echo "Found..."
        #let new_data = getDataChunk(strm)
        #echo new_data
  return {"a": GenericEntry(kind: nkInt, intVal: 0)}.toTable



