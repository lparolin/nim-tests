import generic_entry, hashes

export EntryType

type DataChunk* = object
  name: string
  data: GenericEntry
  trace_id: int
  step_id: int

func MakeDataChunk*[T](name: string, data: T, trace_id: int,
    step_id: int): DataChunk =
  return DataChunk(name: name, data: makeEntry(data), trace_id: trace_id,
      step_id: step_id)

func MakeDataChunk*(name: string, data: GenericEntry, trace_id: int,
    step_id: int): DataChunk =
  return DataChunk(name: name, data: data, trace_id: trace_id, step_id: step_id)

func getName*(in_chunk: DataChunk): string =
  return in_chunk.name

func getTraceId*(in_chunk: DataChunk): int =
  return in_chunk.trace_id

func getStepId*(in_chunk: DataChunk): int =
  return in_chunk.step_id

func hash*(in_chunk: DataChunk): Hash =
  result = in_chunk.name.hash !& in_chunk.data.hash !& in_chunk.trace_id.hash !&
      in_chunk.step_id.hash
  result = !$ result

func `==`*(a: DataChunk, b: DataChunk): bool =
  return a.name == b.name and a.data == b.data and a.trace_id == b.trace_id and
      a.step_id == b.step_id

func getType*(in_data: DataChunk): EntryType =
  return in_data.data.getType

proc getValue*[T](in_data: DataChunk, out_data: var T): bool =
  return getValue(in_data.data, out_data)

func getHeaderForCsvOutput*(): string =
  return "name, value, trace_id, step_id"

func transformToCsvLine*(in_data: DataChunk): string =
  let name_string = "\"" & in_data.name & "\""
  var value_string: string
  let successful_translated = getValue(in_data, value_string)
  if not successful_translated:
    raise newException(ValueError, "Unable to parse data")
  if not (in_data.getType() == nkInt):
    value_string = "\"" & value_string & "\""

  let trace_id = $in_data.trace_id
  let step_id = $in_data.step_id

  return name_string & ", " & value_string & ", " & trace_id & ", " & step_id
