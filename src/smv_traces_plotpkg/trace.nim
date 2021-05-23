import norm/model
import data_chunk
import norm/sqlite
import std/with
import streams

type Trace* = ref object of Model
  variable_name*: string
  value*: string
  trace_id*: int
  step_id*: int

func newTrace*(variable_name: string, value: string, trace_id: int,
    step: int): Trace =
  Trace(variable_name: variable_name,
    value: value,
    trace_id: trace_id,
    step_id: step)

proc newTrace*(in_data: DataChunk): Trace =
  var trace_value: string
  let is_succesful = getValue(in_data, trace_value)
  if not is_succesful:
    raise newException(ValueError, "Unable to correctly parse data from DataChunk")

  Trace(variable_name: getName(in_data),
        value: trace_value,
        trace_id: in_data.getTraceId(),
        step_id: in_data.getStepId()
    )

proc insertData*(in_data: var openArray[Trace], db: var DbConn) =
  with db:
    insert in_data


