xml.instruct! :xml, :version => '1.0', :standalone => "yes"
xml.DASGFF  do
  xml.GFF :version => "1.0", :href => request.url do
    @out_hash.each do |segment,types|
      if @out_hash.include?("all") == false
        if types != "unknown_segment"
          xml.SEGMENT :id => segment.segment_name, :version => "1.0", :start => segment.start, :stop => segment.stop do
            types.each do |type,count|
              xml.TYPE(count, :id => type)
            end
          end
        else
          xml.UNKOWNSEGMENT :id => segment.segment_name
        end
      else
        types.each do |type,count|
          xml.TYPE(count, :id => type)
        end
      end
    end
  end
end