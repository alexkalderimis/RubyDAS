$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

require "rubygems"
require "rubydas/loader/gff3"


DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'sqlite::memory:')

puts "CREATING DB"
DataMapper.auto_migrate!

loader = RubyDAS::Loader::GFF3.new("test/gff3/MAL10.gff3")
loader.store
#loader.gff.records.each do |r| 
#    name = r.get_attribute("Name")
#    ident = r.get_attribute("ID")
#    puts "#{(name || ident)} (#{r.feature}) #{r.seqname}:#{r.start}..#{r.end} #{r.strand}"
#end
#

fs = Feature.all 

puts fs.size

fs.each do |f|
    puts f
end

sgs = Segment.all

puts sgs.size

sgs.each do |s|
    puts "#{s.label}: #{s.features.size} features"
end




