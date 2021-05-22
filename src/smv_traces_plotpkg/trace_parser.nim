import streams
import strutils
import nre
import system
import tables
import hashes
import options
import generic_entry
import data_chunk

const iteration_line_matcher_string = "\\s*-> State:\\s+(\\d+)\\.(\\d+)\\s<-"

func getGroups(instring: string, group_idx_to_parse: int): int =
  let matcher = re(iteration_line_matcher_string)
  let match = instring.find(matcher)
  if match.isSome():
    return match.get.captures[group_idx_to_parse].parseInt()
  else:
    raise newException(IOError, "Unable to parse the given string: " & instring)


func getIterationNumber*(instring: string): int =
  return getGroups(instring, 1)

func getTraceNumber*(instring: string): int =
  return getGroups(instring, 0)

func isIterationLine*(instring: string): bool =
  let local_matcher = re(iteration_line_matcher_string)
  return instring.find(local_matcher).isSome()

proc getNumberOfSteps*(instream: Stream): int =
  var line: string
  var number_of_steps = 0
  while instream.readLine(line):
    if isIterationLine(line):
      number_of_steps = getIterationNumber(line)
  if number_of_steps > 0:
    return number_of_steps
  else:
    raise newException(ValueError, "Unable to get number of steps from the steam")


proc getDataChunk*(strm: Stream): Table[string, GenericEntry] =
  var line = ""
  let parser = re"([^\s]+)\s*=\s*([^\s]+)"
  var temp_data = initTable[string, GenericEntry]()
  while strm.readLine(line) and not isIterationLine(line):
    let match = line.find(parser)
    if match.isSome():
      let variable_name = match.get.captures[0]
      let value = match.get.captures[1]
      temp_data[variable_name] = parseValue(value)
  return temp_data


proc getDataChunk*(trace_index: int, step_index: int, instream: string): Option[
        Table[string, GenericEntry]] =
  var strm = newStringStream(instream)
  var line = ""
  while strm.readLine(line):
    if isIterationLine(line):
      let actual_step_index = getIterationNumber(line)
      let actual_trace_index = getTraceNumber(line)
      if step_index == actual_step_index and
        trace_index == actual_trace_index:
        return some(getDataChunk(strm))

#proc getDataChunk*(trace_index: int, step_index: int, instream: string): Option[DataChunk] =
#  var strm = newStringStream(instream)
#  var line = ""
#  while strm.readLine(line):
#    if isIterationLine(line):
#      let actual_step_index = getIterationNumber(line)
#      let actual_trace_index = getTraceNumber(line)
#      if step_index == actual_step_index and
#        trace_index == actual_trace_index:
#        return some(getDataChunk(strm))

