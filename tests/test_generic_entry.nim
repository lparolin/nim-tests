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


