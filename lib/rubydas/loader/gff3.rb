#
# = rubydas/loader/gff3.rb - GFF loader class
#
# Copyright:: Copyright (C) 2012
#             Alex Kalderimis <alex@intermine.org>
#

require "rubygems"
require "bio"
require "rubydas/model/feature"

module RubyDAS
    module Loader
        class GFF3

            attr_reader :gff

            def initialize
                @types = Hash[]
                @segments = Hash[]
            end

            def store filename
                gff = Bio::GFF::GFF3.new(File.open(filename))
                puts "storing #{filename}"
                gff.records.each do |rec|
                    args = Hash.new
                    if @types.has_key? rec.feature
                        args[:feature_type] = @types[rec.feature]
                    else 
                        args[:feature_type] = @types[rec.feature] = FeatureType.create(:label => rec.feature)
                    end
                    if @segments.has_key? rec.seqname
                        args[:segment] = @segments[rec.seqname]
                    else 
                        args[:segment] = @segments[rec.seqname] = Segment.create(:public_id => rec.seqname, :label => rec.feature)
                    end

                    args[:label] = rec.get_attribute("Name")
                    args[:public_id] = rec.get_attribute("ID")
                    args[:start] = rec.start
                    args[:end] = rec.end
                    args[:score] = rec.score
                    args[:method] = rec.source
                    args[:orientation] = rec.strand
                    if rec.get_attribute("description")
                        args[:notes] = rec.get_attribute("description").split(",").map {|n| {:text => n}}
                    end

                    Feature.make(args)
                    print "."
                    STDOUT.flush
                end
            end
        end
    end
end




