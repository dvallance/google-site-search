module GoogleSiteSearch

	# UrlBuilder is responsible for generating a valid url for querying
	# the google search API.
  class UrlBuilder
		attr_accessor :search_term, :filter, :custom_params, :search_engine_id, :sort

		# ==== Attributes
		#
		# * +search_term+ - should be a simple search with *no* *filters* added.
		#
		# Even though Googles search API uses filters on the search term
		# itself, I wanted to separate out that functionality.
		# Filters should be added separately as a param.
		#
		# * +search_engine_id+ - your unique id found in your Google Site Search
		#   control panel.
		#
		# * +params+ - supply a hash that is converted to query params. See
		#   {Request Params}[https://developers.google.com/custom-search/docs/xml_results?hl=en#wsRequestParameters].
    def initialize search_term, search_engine_id, params = {}
			raise ArgumentError if search_term.blank? || search_engine_id.blank?
      @search_term = search_term
      @search_engine_id = search_engine_id
      @custom_params = params.with_indifferent_access
			@filter = @custom_params.delete :filter
			@sort = @custom_params.delete :sort 
    end

		# Joins the search term and the filters, to get the full search query that google expects.
		def query
			[@search_term,@filter].compact.join(" ")
		end
		
		# Returns a fully qualified URL for the Google search API.
    def url
      "#{GOOGLE_SEARCH_URL}/cse?#{@custom_params.merge(DEFAULT_PARAMS).merge(:q => query, :cx => @search_engine_id, :sort => @sort).delete_if{|k,v| v.nil?}.to_query}" 
    end
		alias :to_s :url

  end
end
