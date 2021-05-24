import unittest
import smv_traces_plotpkg/data_chunk

test "getType when string":
  let mychunk = MakeDataChunk("foo", "content_foo", 1, 1)
  check getType(mychunk) == nkString

test "getType when boolean":
  let mychunk = MakeDataChunk("foo", true, 1, 1)
  check getType(mychunk) == nkBool

test "getType when integer":
  let mychunk = MakeDataChunk("foo", 3, 1, 1)
  check getType(mychunk) == nkInt

test "getValue when string":
  let mychunk = MakeDataChunk("foo", "content_foo", 1, 1)
  var out_val: string
  check getValue(mychunk, out_val) == true
  check out_val == "content_foo"

test "getValue when boolean as boolean":
  let mychunk = MakeDataChunk("foo", true, 1, 1)
  var out_val: bool
  check getValue(mychunk, out_val) == true
  check out_val == true

test "getValue when boolean as string":
  let mychunk = MakeDataChunk("foo", true, 1, 1)
  var out_val: string
  check getValue(mychunk, out_val) == true
  check out_val == $true


#test "getValue when boolean":
#  let mychunk = MakeDataChunk("foo", true, 1, 1)
#  check getValue(mychunk) == true


#test "getValue when integer":
#  let mychunk = MakeDataChunk("foo", 3, 1, 1)
#  check getValue(mychunk) == 3

