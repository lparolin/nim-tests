import unittest
import streams
import smv_traces_plotpkg/trace_parser
import smv_traces_plotpkg/data_chunk
import smv_traces_plotpkg/generic_entry
import smv_traces_plotpkg/generic_entry


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


test "get number of steps":
  check getNumberOfSteps(newStringStream(in_data)) == 15

test "get iteration_lines when it is not":
  check isIterationLine("--> Foo") == false

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

test "get chunk of data when trace 1 step 1":
  check getDataChunk(1, 1, newStringStream(in_data)) == @[
    MakeDataChunk("is_time_to_move", true, 1, 1),
    MakeDataChunk("counter_1.state", 0, 1, 1),
    MakeDataChunk("counter_2.state", 0, 1, 1)]

test "get chunk of data when trace 1 step 5":
  check getDataChunk(1, 5, newStringStream(in_data)) == @[
    MakeDataChunk("is_time_to_move", true, 1, 5),
    MakeDataChunk("counter_1.state", 2, 1, 5),
    MakeDataChunk("counter_2.state", 2, 1, 5)]

test "get chunk of data when trace 2 step 1":
  check getDataChunk(2, 1, newStringStream(in_data)) == newSeq[DataChunk](0)

