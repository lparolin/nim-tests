import generic_entry, hashes

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

func getValue*[T](in_chunk: DataChunk): T =
  return in_chunk.data

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
