xml.instruct! :xml, :version => '1.0', :standalone => "yes"
xml.DASGFF  do
  xml.GFF :version => "1.0", :href => request.url do
    if @features_hash != nil
      @features_hash.each do |segment,features|
        if features != "unknown_segment"
          xml.SEGMENT :id => segment.segment_name, :version => "1.0", :start => segment.start, :stop => segment.stop do
            features.each do |feature|
              xml.FEATURE :id => feature.id do 
                xml.TYPE :id => feature.feature_type.label
                xml.METHOD :id => feature.method
                xml.START feature.start
                xml.END feature.end
                if feature.score != nil 
                  xml.SCORE feature.score 
                end
                if feature.orientation != nil
                  xml.ORIENTATION feature.orientation
                end
                if feature.phase != nil
                  xml.PHASE feature.phase
                end
                feature.notes.each do |n|
                  xml.NOTE n.text
                end
                feature.links.each do |l| 
                  xml.LINK(l.text, :href => l.href)
                end
              end 
            end
          end
        else
          xml.UNKOWNSEGMENT :id => segment.segment_name
        end
      end
    end
  end
end
