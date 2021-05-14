import streams
import strutils
import nre
import system

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
