module GoogleSiteSearch

	# A default class that parses a result element from 
	# Googles search API.
	#
	# See {LibXML Ruby's Node}[http://libxml.rubyforge.org/rdoc/classes/LibXML/XML/Node.html] when writing your own Result class.
	class Result
		attr_reader :title, :link, :description
		
		# ==== Attributes
		#
		# * +node+ - LibXML::XML::Node.
		def initialize(node)
			@title = node.find_first("T").content

			# Fully qualified URL to the result.
			@link = node.find_first("UE").content

			@description = node.find_first("S").content
		end
	end
end
