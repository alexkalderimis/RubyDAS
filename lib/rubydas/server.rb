require 'sinatra'
require 'rubygems'
require 'cgi'
require 'data_mapper' 
require 'builder'
require "/Users/gedankenstuecke/Documents/RubyDAS/lib/rubydas/model/feature"


class SegmentCall
  attr_accessor :segment_name,:start,:stop
  def initialize(segment_name,start,stop)
    @segment_name = segment_name
    @start = start
    @stop = stop
  end
end
  

get '/das/rubydas/features' do
  
  DataMapper.setup(:default, 'sqlite:///Users/gedankenstuecke/Documents/RubyDAS/data/test.db')
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
      @segments << SegmentCall.new(@segment_name,false,false)
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
  
  # now the fun part starts, check for all the different parameter-things which can be available
  # case #1: segments not empty
  if @segments != []
    @features_hash = {}
    @segments.each do |s|
      
      if Segment.all(:public_id => s.segment_name) != []
        @segment_id = Segment.first(:public_id => s.segment_name).id
        if s.start != false and s.stop != false 
          @local_features = Feature.all(:segment_id => @segment_id, :start.gte => s.start, :start.lte => s.stop) | Feature.all(:end.gte => s.start, :end.lte => s.stop)
        else
          @local_features = Feature.all(:segment_id => @segment_id, :order => [:start.asc])
          s.start = @local_features[0].start
          s.stop = @local_features[-1].end
        end
        
        # if types not empty filter for those type-labels which are requested
        if @types != [] 
          @filtered_features = []
          @local_features.each do |lf| 
            if @types.include?(lf.feature_type.label) 
              @filtered_features << lf
            end
          end
          @local_features = @filtered_features
        end
        
        # if categories not empty filter for those type-categories which are requested
        if @categories != []
          @filtered_features = []
          @local_features.each do |lf|
            if @categories.include?(lf.feature_type.category)
              @filtered_features << lf
            end
          end
          @local_features = @filtered_features
        end
        
        # add those filtered features to features-hash. key => segment-class, value = array of features
        @features_hash[s] = @local_features
        
      else
        @features_hash[s] = "unkown_segment"
      end
    end
  end
  
  response.headers["X-DAS-Capabilities"] = "features/1.1"
  response.headers["X-DAS-Server"] = request.env["SERVER_SOFTWARE"].split(" ")[0]
  response.headers["Access-Control-Allow-Origin"] = "*"
  response.headers["X-DAS-Status"] = "200"
  response.headers["X-DAS-Version"] = "DAS/1.6"
  
  builder :features

end
