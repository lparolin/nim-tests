import smv_traces_plotpkg/trace_parser
import smv_traces_plotpkg/data_chunk
import streams
import sequtils
import smv_traces_plotpkg/sql_trace
import norm/sqlite

when isMainModule:
  let in_file = r"input.tr"
  let out_file = r"output.csv"
  let in_stream = newFileStream(in_file, fmRead)
  let out_data = parseAllStream(in_stream)
  var out_stream = newFileStream("output.csv", fmWrite)

  let header_string = getHeaderForCsvOutput()
  out_stream.writeLine(header_string)

  for i_data in out_data.items:
    out_stream.writeLine(i_data.transformToCsvLine())

  echo "CSV file created" & out_file

  let out_db = r"output.db"
  var dbConn = open(out_db, "", "", "")
  dbConn.createTables(SqlTrace())
  var sql_data = map(out_data, newSqlTrace)
  insertData(sql_data, dbConn)

  echo "SqlLite file created: " & out_db
