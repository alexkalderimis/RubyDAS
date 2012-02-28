$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

require "rubygems"
require "data_mapper"
require "rubydas/model/feature"

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'sqlite::memory:')

puts "CREATING DB"
DataMapper.auto_migrate!

adapter = DataMapper.repository(:default).adapter

p adapter

puts "CREATING TYPE"
t = FeatureType.create(:label => "type-a")

puts "CREATING SEGMENT"
s = Segment.create(:public_id => "10", :label => "MAL10")

puts "CREATING FEATURE"
f = Feature.new(:segment => s, :public_id => "ENGN0001234", :label => "feature-a", :start => 100, :end => 200, :score => 1.234, :feature_type => t)

p f
puts "NEW FEATURE #{f} id=#{f.id}"

if (f.save) 
    puts "Hooray"
else
    puts f.errors
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

f2 = Feature.make(:segment => s, :public_id => "ENGN0001234", :label => "feature-b", :start => 100, :end => 200, :score => 1.234, :feature_type => t, 
                 :notes => [{:text => "some text"}, {:text => "more text"}],
                 :links => [
                     {:href => "http://somewhere.org", :link_text => "somewhere"}, 
                     {:href => "http://somewhere.else.org", :link_text => "somewhere else"}
                 ],
                 :targets => [
                     {:start => 0, :stop => 1, :name => "foo"},
                     {:start => 0, :stop => 3, :name => "boo"},
                     {:start => 0, :stop => 5, :name => "coo"}
                 ]
                 )

                 f2 = Feature.make(:segment_id => "MY-SEGMENT", :public_id => "ENGN0001234", :label => "feature-c", :start => 200, :end => 400, :score => 1.234, :type => "label -b", 
                 :notes => [{:text => "some text"}, {:text => "more text"}],
                 :links => [
                     {:href => "http://somewhere.org", :link_text => "somewhere"}, 
                     {:href => "http://somewhere.else.org", :link_text => "somewhere else"}
                 ],
                 :targets => [
                     {:start => 0, :stop => 1, :name => "foo"},
                     {:start => 0, :stop => 3, :name => "boo"},
                     {:start => 0, :stop => 5, :name => "coo"}
                 ]
                 )


puts "QUERYING"
fs = Feature.all

puts fs.size

fs.each do | f | 
    puts "FEATURE = #{f.label}, #{f.feature_type.label} #{f.segment.label}"
    f.notes.each {|n| puts n.text}
    f.targets.each {|n| p n}
    f.links.each {|n| p n}
end

puts "QUERYING 3"
ns = Note.all

puts "NOTES: #{ns.size}"

ns.each do |n| 
    puts n 
end

puts "QUERYING 4"
ls = Link.all

puts "LINKS: #{ls.size}"

ls.each do |n| 
    puts n 
end

puts "QUERYING 5"
ls = Target.all

puts "TARGET: #{ls.size}"

ls.each do |n| 
    puts n 
end


