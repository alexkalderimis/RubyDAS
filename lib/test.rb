require "rubygems"
require "data_mapper"
require "rubydas/model/feature"

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'postgres://alex:alex@localhost/rubydas')

puts "CREATING DB"
DataMapper.auto_migrate!

adapter = DataMapper.repository(:default).adapter

p adapter

puts "CREATING TYPE"
t = Type.create(:label => "type-a")

puts "CREATING FEATURE"
f = Feature.new(:label => "feature-a", :start => 100, :stop => 200, :score => 1.234, :type => t)

p f
puts "NEW FEATURE #{f} id=#{f.id}"

if (f.save) 
    puts "Hooray"
else
    f.errors.each { |e| puts e }
end

new_f = Feature.get(f.id)

puts "THAT IS #{new_f}"

puts "QUERYING"
fs = Feature.all

puts fs.size

fs.each do | f | 
    puts "FEATURE = #{f}"
end
