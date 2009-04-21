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