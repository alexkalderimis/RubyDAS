require "rubygems"
require "bio"
require "rubydas/model/sequence"

module RubyDAS
    module Loader
        class FASTA

            def store filename
                puts "Storing #{filename}"
                ff = Bio::FlatFile.open(Bio::FastaFormat, filename)
                ff.each do |entry|
                    s = Sequence.new(
                        :public_id => entry.entry_id,
                        :length => entry.length,
                        :label => entry.entry_id
                    )
                    unless s.save
                        raise s.errors.reduce("Error saving:") {|m, e| m + e.to_s}
                    end
                    current_seq = ""
                    pos = 0
                    entry.seq.each_char do |c|
                        pos += 1
                        current_seq << c
                        if current_seq.length >= 1000
                            sf = SequenceFragment.new(
                                :fragment => current_seq,
                                :start => pos - current_seq.length,
                                :end => pos,
                                :sequence => s
                            )
                            unless sf.save
                                raise sf.errors.reduce("Error saving:") do |m, e| 
                                    m + e.to_s
                                end
                            end
                            current_seq = ""
                            print "."
                            STDOUT.flush
                        end
                    end
                end
            end
        end
    end
end

