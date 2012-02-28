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

            def initialize filename
                @gff = Bio::GFF::GFF3.new(File.open(filename))
            end

            def store
                @gff.records.each do |rec|
                    args = Hash.new
                    args[:segment_id] = rec.seqname
                    args[:label] = rec.get_attribute("Name")
                    args[:public_id] = rec.get_attribute("ID")
                    args[:type] = rec.feature
                    args[:start] = rec.start
                    args[:end] = rec.end
                    args[:score] = rec.score
                    args[:method] = rec.source
                    args[:orientation] = rec.strand
                    if rec.get_attribute("Description")
                        args[:notes] = rec.get_attribute("Description").split(",").map {|n| {:text => n}}
                    end

                    Feature.make(args)
                end
            end
        end
    end
end




