require 'rubygems'
require 'data_mapper'

class Sequence
    include DataMapper::Resource

    property :id, Serial
    property :public_id, String
    property :label, String
    property :moltype, String
    property :version, String
    property :length, Integer
  
    has n, :sequence_fragments
end

class SequenceFragment
    include DataMapper::Resource

    property :id, Serial
    property :fragment, Text
    property :start, Integer
    property :end, Integer

    belongs_to :sequence
end

DataMapper.finalize


