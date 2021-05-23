import smv_traces_plotpkg/trace_parser
import smv_traces_plotpkg/data_chunk
import streams
import sequtils
import smv_traces_plotpkg/trace
import norm/sqlite

when isMainModule:
  let in_file = r"nusmv_model_examples/trace_example1.tr"
  let in_stream = newFileStream(in_file, fmRead)
  let out_data = parseAllStream(in_stream)
  var out_stream = newFileStream("out_data.csv", fmWrite)

  let header_string = getHeaderForCsvOutput()
  out_stream.writeLine(header_string)

  for i_data in out_data.items:
    out_stream.writeLine(i_data.transformToCsvLine())

  echo "CSV file created"

  let out_db = r"outdata.db"
  var dbConn = open(out_db, "", "", "")
  dbConn.createTables(Trace())
  var sql_data = map(out_data, newTrace)
  insertData(sql_data, dbConn)
