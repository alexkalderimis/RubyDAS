xml.instruct! :xml, :version => '1.0', :standalone => "yes"
xml.DASEP do
  xml.ENTRY_POINTS :href => request.url, :total => @sequences.size, :start => @sequences[0].public_id, :end => @sequences[-1].public_id do
    @sequences.each do |s|
      xml.SEGMENT(s.label, :id => s.public_id, :start => 1, :stop => s.length, :version => s.version, :orientation => "+")
    end
  end
end
