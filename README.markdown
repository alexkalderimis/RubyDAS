A gem to use the Distributed Annotation System with Ruby. 

= DAS
The [Distributed Annotation System](http://en.wikipedia.org/wiki/Distributed_Annotation_System) is a protocol developed to allow the distributed annotation of nucleotide and protein sequences. DAS servers are used to deliver reference sequences and/or annotations for those sequences. DAS clients can be used to remix the information from different sources and deliver a single representation of the information. Examples for DAS-clients are [ENSEMBL Genome Browser](http://www.ensembl.org/Homo_sapiens/Gene/Summary?g=ENSG00000139618;r=13:32889611-32973805), [Spice](http://www.efamily.org.uk/software/dasclients/spice) and [Dalliance](http://biodalliance.org). 

Widely-used DAS-server-implementations are [myDAS](http://code.google.com/p/mydas/) – which is based on Java – and [ProServer](http://www.sanger.ac.uk/resources/software/proserver/) which is based on Perl. 

= RubyDAS
RubyDAS tries to provide a reference- and annotation-server with the DAS 1.6 standard based on Ruby. Reference-sequences and the annotations are stored in a database of choice using Datamapper. The dependencies of RubyDAS as of now are: 
* [BioRuby](http://bioruby.open-bio.org/)
* [Sinatra](http://www.sinatrarb.com/)
* [http://datamapper.org/](http://datamapper.org/)

== Features
* Read GFF3
* Read FASTA 
* DAS *sequences*-command
* DAS *sources*-command 
* DAS *features*-commands

== How-To
To test the current implementation just run server.rb and point your browser to localhost:4567/das/rubydas/sequence?segment=MAL5:1000,2000 localhost:4567/das/rubydas/types?segment=MAL5:1000,2000 or localhost:4567/das/rubydas/features?segment=MAL5:1000,2000

== To-Do
* Implement *entry_points*
* Implement *sources*
* Add further input-file-formats
* Test compatibility with DAS-clients

== Contact
If you are interested in joining the development of RubyDAS you can join the Google Group/mailinglist at https://groups.google.com/group/rubydas 

