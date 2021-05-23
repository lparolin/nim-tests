import norm/model
import data_chunk
import norm/sqlite
import std/with
import streams

type Trace* = ref object of Model
  variable_name*: string
  value: string
  trace_id: int
  step_id: int

func newTrace*(variable_name: string, value: string, trace_id: int,
    step: int): Trace =
  Trace(variable_name: variable_name,
    value: value,
    trace_id: trace_id,
    step_id: step)

func newTrace*(in_data: DataChunk): Trace =
  Trace(variable_name: getName(in_data),
        value: $(getValue(in_data)),
        trace_id: in_data.getTraceId(),
        step_id: in_data.getStepId()
    )

proc dumpData*(in_data: var openArray[Trace], db: DbConn) =
  with db:
    insert in_data


proc dumpData*(in_data: openArray[Trace], out_stream: var FileStream,
    write_header = true) =
  if (write_header):
    out_stream.writeLine("variable_name, value, trace_id, step_id")

  for i_data in in_data.items:
    let new_line = "\"" & i_data.variable_name & "\", " & i_data.value &
      ", " & $i_data.trace_id & ", " & $i_data.step_id
    out_stream.writeLine(new_line)

