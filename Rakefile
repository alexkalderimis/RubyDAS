require 'rubygems'
require 'rubygems/specification' unless defined?(Gem::Specification)
require 'rake/testtask'
require 'rake/gempackagetask'
gem 'rdoc', '=2.1.0'
require 'rdoc/rdoc'
require 'rake/rdoctask'

def gemspec
    @gemspec ||= begin
        Gem::Specification.load(File.expand_path('rubydas.gemspec'))
    end
end

task :default => :test

desc 'Start a console session'
task :console do
    system 'irb -I lib -r rubydas'
end

desc 'Displays the current version'
task :version do 
    puts "Current version: #{gemspec.version}"
end

desc 'Installs the gem locally'
task :install => :package do
    sh "gem install pkg/#{gemspec.name}-#{gemspec.version}"
end

desc 'Release the gem'
task :release => :package do
      sh "gem push pkg/#{gemspec.name}-#{gemspec.version}.gem"
end

Rake::GemPackageTask.new(gemspec) do |pkg|
    pkg.need_zip = true
    pkg.need_tar = true

end

Rake::TestTask.new do |t|
    t.libs << "test"
    t.test_files = FileList['test/test.rb']
    t.verbose = true
end

Rake::TestTask.new(:live_tests) do |t|
    t.libs << "test"
    t.test_files = FileList['test/live_test.rb'] << FileList['test/live_summary_test.rb'] << FileList['test/live_results.rb']
    t.verbose = true
end

task :build_test_db do
    require "rubydas/model/feature"
    require "rubydas/model/sequence"
    require "data_mapper"
    DataMapper.setup(:default, 'sqlite:data/test.db')
    DataMapper.auto_migrate!
end

task :load_test_gff3 do
    require "rubydas/loader/gff3"
    require "data_mapper"
    DataMapper.setup(:default, 'sqlite:data/test.db')
    DataMapper.auto_upgrade!
    loader = RubyDAS::Loader::GFF3.new
    Dir.glob("test/gff3/MAL*gff3") do |name|
        loader.store name
    end
end

task :load_test_fa do
    require "rubydas/loader/fasta"
    require "data_mapper"
    DataMapper.setup(:default, 'sqlite:data/test.db')
    DataMapper.auto_upgrade!
    loader = RubyDAS::Loader::FASTA.new
    Dir.glob("test/fasta/MAL*fasta") do |name|
        loader.store name
    end
end

task :build_test_fixture => [:build_test_db, :load_test_fa, :load_test_gff3] do
    puts "Loaded test fixture"
end





