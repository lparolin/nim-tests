import smv_traces_plotpkg/trace_parser
import streams
import sequtils
import smv_traces_plotpkg/trace
import norm/sqlite

when isMainModule:
  let in_file = r"nusmv_model_examples/trace_example1.tr"
  let in_stream = newFileStream(in_file, fmRead)
  let out_data = parseAllStream(in_stream)
  var out_stream = newFileStream("out_data.csv", fmWrite)
  var sql_data = map(out_data, newTrace)
  dumpData(sql_data, out_stream)

  echo "Work executed"

  #let out_db = r"outdata.db"
  #let dbConn = open(out_db, "", "", "")
  #dbConn.createTables(Trace())
  #var sql_data = map(out_data, newTrace)
  #dumpData(sql_data, dbConn)
