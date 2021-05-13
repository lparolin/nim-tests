# This is just an example to get you started. Users of your hybrid library will
# import this file by writing ``import smv_traces_plotpkg/submodule``. Feel free to rename or
# remove this file altogether. You may create additional modules alongside
# this file as required.

import streams
import strutils

func isIterationLine*(instring: string) : bool = 
  const iteration_identifier_line = "-> State: "
  return iteration_identifier_line in instring

proc getNumberOfSteps*(instream : Stream) : int = 
  var line : string 
  while instream.readLine(line):
    echo line 
  return 2
