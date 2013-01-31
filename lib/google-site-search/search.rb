module GoogleSiteSearch

  class ParsingError < StandardError; end;
  class Error404 < StandardError; end;

	# Search is responsible for parsing the returned xml from
	# google's API.
	#
	# XML parsing is done using {LibXML Ruby}[http://libxml.rubyforge.org/rdoc/]
  class Search
		# Goolge Site Search API url.
    attr_reader :url
		# Array of *result_class* objects.
    attr_reader :results
		# Spelling suggestion in HTML format.
    attr_reader :spelling
		# Spelling suggestion URL escaped.
    attr_reader :spelling_q
		# Pulled from the XML as the estimated total number of results.
		# *Note* Google themselves say this may not be accurate. 
    attr_reader :estimated_results_total
		# Relative URL to get the next set of results (if any).
    attr_reader :next_results_url
		# Relative URL to get the previous set of results (if any).
    attr_reader :previous_results_url
		# String of the xml returned by Google.
    attr_reader :xml
		# Class supplied which is responsible for parsing each
		# individual result from the API XML.
    attr_reader :result_class
		# The full search term + filters query google interpreted from
		# the url supplied.
    attr_reader :search_query

		# ==== Attributes
		#
		# * +url+ - Expects a fully qualified url to Googles search API
		#   (can be a string or from an objects to_s method).
		# * +reulst_class+ - A class that's initialize method is expected
		#   to handle the parsing of an individual result entry. 
    def initialize url, result_class
      @url = url.to_s
      @results = Array.new
      @result_class = result_class
      @synonyms = []
    end

    def next_results_url  
      @next_results_url
    end

    def previous_results_url
      @previous_results_url
    end


		# Query's Google API, stores the xml and parses values into itself.
    def query
      @xml = GoogleSiteSearch::request_xml(url)
      parse_xml unless @xml.nil?
			self
    end

    def results
      @results || []
    end

    def synonyms
      [@synonyms].compact.flatten
    end

    private

    def parse_xml
      begin
        doc = ::XML::Parser.string(@xml).parse
        doc.find("//GSP/RES/R").each do |result_node|
          @results << result_class.new(result_node)
        end

        spelling_node = doc.find_first("Spelling/Suggestion")
        @spelling = spelling_node.try(:content) 
        @spelling_q = spelling_node.try(:attributes).try(:[],:q)
        nodes = doc.find("Synonyms/OneSynonym")
        nodes.each do |synonym|
          @synonyms << synonym.content 
        end
        @estimated_results_total = doc.find_first("RES/M").try(:content)
        @next_results_url = remove_search_engine_id(doc.find_first("RES/NB/NU").try(:content))
        @previous_results_url = remove_search_engine_id(doc.find_first("RES/NB/PU").try(:content))
        @search_query = doc.find_first("Q").try(:content)
      rescue Exception => e
        raise ParsingError, "#{e.message} Class:[#{e.class}] URL:[#{@url}] XML:[#{@xml}]"
      end
    end

    def remove_search_engine_id url
      return nil if url.blank?
      uri = URI.parse(url)
      params = Rack::Utils::parse_query(uri.query)
      params.delete("cx")
      uri.query = params.to_query
      uri.to_s
    end
  end
end
