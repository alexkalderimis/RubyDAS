require 'sinatra'
require 'rubygems'
require 'cgi'
require 'data_mapper' 
require "rubydas/model/feature"


class SegmentCall
  attr_accessor :segment_name,:start,:stop
  def initialize(segment_name,start,stop)
    @segment_name = segment_name
    @start = start
    @stop = stop
  end
end
  

get '/das/rubydas/features' do
  
  DataMapper.setup(:default, 'sqlite:///Users/gedankenstuecke/Documents/RubyDAS/lib/test.db')
  adapter = DataMapper.repository(:default).adapter
  
  @query = CGI.parse(request.query_string)
  
  # get list of all segments and regions of interest 
  @segments = []
  @query["segment"].each do |s|
    @segment_elements = s.split(":")
    @segment_name = @segment_elements[0]
    if @segment_elements[1] != nil
      @positions = @segment_elements[1].split(",")
      @start = @positions[0]
      @stop = @positions[1]
      @segments << SegmentCall.new(@segment_name,@start,@stop)
    else
      @segments << SegmentCall.new(@segment_name,0,0)
    end
  end   
  
  # get all types which are of interest 
  @types = []
  @query["type"].each {|t| @types << t}
  
  # get all categories of interest 
  @categories = []
  @query["category"].each {|c| @categories << c}
  
  # get all feature_ids of interest
  @feature_ids = []
  @query["feature_id"].each {|f| @feature_ids << f}
  
  # get all group_ids of interest
  @group_ids = []
  @query["group_id"].each {|g| @group_ids << g}
  
  @segments.to_s
  "Types: "+@types.to_s + "<br/>"+ "Group-ID: "+@group_ids.to_s+"<br/>"+"Feature-ID: "+@feature_ids.to_s+"<br/>"+"Segments: "+@segments.to_s+"<br/>Categories:"+@categories.to_s

  # now the fun part starts, check for all the different parameter-things which can be available
  # case #1: segments not empty
  if @segments != []
    @features_hash = {}
    @segments.each do |s|
      @local_features = Feature.all(:start.gte => s.start, :start.lte => s.stop) | Feature.all(:stop.gte => s.start, :stop.lte => s.stop)
        

end