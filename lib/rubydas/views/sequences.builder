xml.instruct! :xml, :version => '1.0', :standalone => "yes"
xml.declare! :DOCTYPE, :DASSEQUENCE, :SYSTEM, "http://www.biodas.org/dtd/dassequence.dtd"
  xml.DASSEQUENCE do 
  @out_hash.each do |segment,sequence|
    if @out_hash.include?("empty") == false
        if sequence != "unknown_segment"
          xml.SEQUENCE(sequence, :id => segment.segment_name, :version => "1.0", :start => segment.start, :stop => segment.stop)
        else
          xml.UNKOWNSEGMENT :id => segment.segment_name
        end
    else
      xml.DASSEQUENCE do
        xml.UNKOWNSEGMENT :id => segment.segment_name
      end
    end
  end
end