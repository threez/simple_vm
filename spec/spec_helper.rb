$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require "rubygems"
require "spec"
require "simplevm"

SAMPLE_CODE = File.read(File.dirname(__FILE__) + "/sample.sl")
FIB_CODE = File.read(File.dirname(__FILE__) + "/fib.sl")
MATH_CODE = File.read(File.dirname(__FILE__) + "/math.sl")
