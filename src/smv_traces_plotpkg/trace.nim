import norm/model
import data_chunk

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
