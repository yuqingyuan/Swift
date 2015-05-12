// RUN: not %swift -parse -target %target-triple %s -emit-fixits-path %t.remap -serialize-diagnostics-path %t.dia
// RUN: c-arcmt-test %t.remap | arcmt-test -verify-transformed-files %s.result
// RUN: c-index-test -read-diagnostics %t.dia > %t.deserialized_diagnostics.txt 2>&1
// RUN: FileCheck --input-file=%t.deserialized_diagnostics.txt %s

// CHECK: Number of diagnostics: 5

class Base {}
class Derived : Base {}

var b : Base
b as Derived
b as Derived

b as! Base

var opti : Int?
// Don't add bang.
var i : Int = opti
// But remove unecessary bang.
var i2 : Int = i!
