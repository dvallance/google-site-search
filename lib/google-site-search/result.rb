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
			@title = node.find_first("T").try(:content)

			# Fully qualified URL to the result.
			@link = node.find_first("UE").try(:content)

			@description = node.find_first("S").try(:content)

      #check for custom search description when not regular search result
      if @description.empty?
        @description = node.find_first("//BLOCK /T").try(:content)
      end
		end
	end
end
