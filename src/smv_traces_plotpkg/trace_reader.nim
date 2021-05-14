# This is just an example to get you started. Users of your hybrid library will
# import this file by writing ``import smv_traces_plotpkg/submodule``. Feel free to rename or
# remove this file altogether. You may create additional modules alongside
# this file as required.

import streams
import strutils
import nre
import system

func getGroups(instring: string, group_idx_to_parse: int) : int = 
  let matcher = re"\s*-> State:\s+(\d+)\.(\d+)\s<-"
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
  const iteration_identifier_line = "-> State: "
  return iteration_identifier_line in instring

proc getNumberOfSteps*(instream : Stream) : int = 
  var line : string 
 # while instream.readLine(line):
 #   echo line 
  return 2
