$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require "rubygems"
require "spec"
require "simplevm"

SAMPLE_CODE = File.read(File.dirname(__FILE__) + "/sample.sl")
