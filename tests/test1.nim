# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest
import streams 

import smv_traces_plotpkg/trace_reader



test "get variables":
  let in_data = """
********  Simulation Starting From State 1.1   ********
Trace Description: Simulation Trace 
Trace Type: Simulation 
  -> State: 1.1 <-
    is_time_to_move = TRUE
    counter_1.state = 0
    counter_2.state = 0
  -> State: 1.2 <-
    is_time_to_move = FALSE
    counter_1.state = 1
    counter_2.state = 0
  -> State: 1.3 <-
    is_time_to_move = TRUE
    counter_1.state = 1
    counter_2.state = 1
  -> State: 1.4 <-
    is_time_to_move = FALSE
    counter_1.state = 2
    counter_2.state = 1
  -> State: 1.5 <-
    is_time_to_move = TRUE
    counter_1.state = 2
    counter_2.state = 2
  -> State: 1.6 <-
    is_time_to_move = FALSE
    counter_1.state = 3
    counter_2.state = 2
  -> State: 1.7 <-
    is_time_to_move = FALSE
    counter_1.state = 3
    counter_2.state = 3
  -> State: 1.8 <-
    is_time_to_move = TRUE
    counter_1.state = 3
    counter_2.state = 4
  -> State: 1.9 <-
    is_time_to_move = FALSE
    counter_1.state = 4
    counter_2.state = 4
  -> State: 1.10 <-
    is_time_to_move = FALSE
    counter_1.state = 4
    counter_2.state = 5
  -> State: 1.11 <-
    is_time_to_move = FALSE
    counter_1.state = 4
    counter_2.state = 6
  -> State: 1.12 <-
    is_time_to_move = FALSE
    counter_1.state = 4
    counter_2.state = 7
  -> State: 1.13 <-
    is_time_to_move = TRUE
    counter_1.state = 4
    counter_2.state = 8
  -> State: 1.14 <-
    is_time_to_move = FALSE
    counter_1.state = 5
    counter_2.state = 8
  -> State: 1.15 <-
    is_time_to_move = TRUE
    counter_1.state = 5
    counter_2.state = 9
  """
  
  check getNumberOfSteps(newStringStream(in_data)) == 15 

test "get iteration_lines when it is not":
  check isIterationLine("--> Bubu") == false

test "get iteration_lines when it is":
  check isIterationLine("  -> State: 1.3 <-  ") == true

test "get iteration number when 3":
  check getIterationNumber("  -> State: 1.3 <-  ") == 3

test "get iteration number when 1":
  check getIterationNumber("  -> State: 1.1 <-  ") == 1

test "get iteration number when 21":
  check getIterationNumber("  -> State: 1.21 <-  ") == 21

test "get trace number when 1":
  check getTraceNumber("  -> State: 1.3 <-  ") == 1

test "get trace number when 3":
  check getTraceNumber("  -> State: 3.1 <-  ") == 3

