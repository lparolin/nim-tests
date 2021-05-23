import unittest
import smv_traces_plotpkg/generic_entry


test "test make entry when integer":
  check makeEntry(1) == GenericEntry(kind: nkInt, intVal: 1)

test "test make entry when string":
  check makeEntry("bubu") == GenericEntry(kind: nkString, stringVal: "bubu")

test "test make entry when integer":
  check makeEntry(true) == GenericEntry(kind: nkBool, boolVal: true)

test "test equality when different type":
  let value_1 = makeEntry(1)
  let value_2 = makeEntry(true)
  check value_1 != value_2

test "test equality when same type but different content":
  let value_1 = makeEntry(1)
  let value_2 = makeEntry(2)
  check value_1 != value_2

test "test equality when same type and identical content":
  let value_1 = makeEntry("aa")
  let value_2 = makeEntry("aa")
  check value_1 == value_2

test "parsable value when boolean true":
  check parseValue("  true   ") == makeEntry(true)

test "parsable value when boolean true and capital letter":
  check parseValue("  TRUE   ") == makeEntry(true)

test "parsable value when boolean false":
  check parseValue("  false   ") == makeEntry(false)

test "parsable value when boolean false and capital letter":
  check parseValue("  FALSE   ") == makeEntry(false)

test "parsable value when integer 0 ":
  check parseValue("  0 ") == makeEntry(0)

test "parsable value when simple string ":
  check parseValue("  Lambda.One ") == makeEntry("Lambda.One")

test "parsable value when complex string ":
  check parseValue("  lambda_one_two") == makeEntry("lambda_one_two")

test "get value when integer 10 and request is integer":
  var new_value: int
  check getValue(makeEntry(10), new_value) == true
  check new_value == 10

test "get value when integer 10 and request is boolean":
  var new_value: bool
  check getValue(makeEntry(10), new_value) == false

test "get value when integer 10 and request is string":
  var new_value: string
  check getValue(makeEntry(10), new_value) == true
  check new_value == "10"

test "get value when string and request is integer":
  var new_value: int
  check getValue(makeEntry("test"), new_value) == false

test "get value when string and request is boolean":
  var new_value: bool
  check getValue(makeEntry("test"), new_value) == false

test "get value when string and request is string":
  var new_value: string
  check getValue(makeEntry("test"), new_value) == true
  check new_value == "test"

test "get value when bool and request is integer":
  var new_value: int
  check getValue(makeEntry(true), new_value) == false

test "get value when bool and request is boolean":
  var new_value = false
  check getValue(makeEntry(true), new_value) == true
  check new_value == true

test "get value when bool and request is string":
  var new_value: string
  check getValue(makeEntry(true), new_value) == true
  new_value = "true"


