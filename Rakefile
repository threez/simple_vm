require 'rubygems'
require 'spec/rake/spectask'

task :default => :spec

desc "create parser based on treetop definition"
task :parser do
  sh "tt treetop/grammar.treetop"
  mv "treetop/grammar.rb", "lib/simplevm/parser.rb"
end

desc "run the specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/spec*.rb']
end

namespace :compile do
  desc "compile samples"
  task :samples do
    require "spec/spec_helper"

    Dir["spec/*.sl"].each do |slfile|
      code = File.read(slfile)    
      File.open(File.basename(slfile) + "c", "w") do |f|
        f.write ByteCodeCompiler.compile(code)
      end
    end
  end

  desc "compile the c vm"
  task :vm do
    sh "gcc src/slvm.c -W -O2 -o bin/slvm_c"
  end

  desc "compile the c vm with debugging"
  task :vm_debug do
    sh "gcc src/slvm.c -W -g -o bin/slvm_c_debug -DDEBUG"
  end
end
