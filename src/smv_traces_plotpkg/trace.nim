import norm/model

type Trace* = ref object of Model
  variable_name*: string
  value: float
  trace_id: int
  step: int

func newTrace*(variable_name: string, value: float, trace_id: int,
    step: int): Trace =
  Trace(variable_name: variable_name,
    value: value,
    trace_id: trace_id,
    step: step)

