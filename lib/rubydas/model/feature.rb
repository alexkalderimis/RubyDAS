require 'rubygems'
require 'data_mapper' # requires all the gems listed above

class Feature
  include DataMapper::Resource

  property :id,         Serial    # An auto-increment integer key
  property :label,      String    # A varchar type string, for short strings
  property :start,       Integer      # A text block, for longer string data.
  property :stop,       Integer      # A text block, for longer string data.
  property :method, String  # A DateTime, for any date you might like.
  property :score, Float
  property :phase, Enum[ '0', '1', '2', '-' ]
  property :orientation, Enum[ '0', '-', '+' ]

  has n, :links
  has n, :notes
  has n, :targets
  has n, :parents, self
  has n, :parts, self
  
  belongs_to :type 
  
end

class Target
  include DataMapper::Resource

  property :id, Serial
  property :start,       Integer      # A text block, for longer string data.
  property :stop,       Integer      # A text block, for longer string data.
  property :name, String

  belongs_to :feature
end

class Note
  include DataMapper::Resource

  property :id, Serial
  property :text, String
  belongs_to :feature

end

class Link
  include DataMapper::Resource

  property :id, Serial
  property :href, String
  property :link_text, String 
  
  belongs_to :feature
end

class Type
  include DataMapper::Resource
  
  property :id, Serial
  property :category, String
  property :reference, Boolean
  property :label, String

  has n, :features
  
end
 
DataMapper.finalize


