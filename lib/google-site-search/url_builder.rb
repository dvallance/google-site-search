module GoogleSiteSearch
  
  GOOGLE_SEARCH_URL = "http://www.google.com"
  DEFAULT_PARAMS = {
    :output => "xml_no_dtd",
    :client => "google-csbe",
    :ie => "utf8"
  }.with_indifferent_access

  DEFAULT_PARAMS_FOR_APPLIANCE = {
    :output => "xml_no_dtd",
    :client => "default_frontend",
    :ie => "utf8"
  }.with_indifferent_access

	# UrlBuilder is responsible for generating a valid url for querying
	# the google search API.
  class UrlBuilder
		attr_accessor :search_term, :filter, :custom_params, :search_engine_id, :sort, :host

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
    def initialize search_term, search_engine_id_or_host, params = {}
			raise ArgumentError if search_term.blank? || search_engine_id_or_host.blank?
      @search_term = search_term
      @search_engine_id = search_engine_id_or_host if GoogleSiteSearch::looks_like_search_engine_id?(search_engine_id_or_host)
      @host = search_engine_id_or_host if GoogleSiteSearch::looks_like_host?(search_engine_id_or_host)
      @custom_params = params.with_indifferent_access
			@filter = @custom_params.delete :filter
			@sort = @custom_params.delete :sort 
      @gsa_filter = @custom_params.delete :gsa_filter
    end

		# Joins the search term and the filters, to get the full search query that google expects.
		def query
			[@search_term,@filter].compact.join(" ")
		end
		
		# Returns a fully qualified URL for the Google search API.
    def url
      "#{@host.nil? ? (GOOGLE_SEARCH_URL + "/cse") : @host }?#{(using_google_appliance? ? DEFAULT_PARAMS_FOR_APPLIANCE : DEFAULT_PARAMS.merge(:cx => @search_engine_id)).merge(@custom_params).merge(:q => query, :sort => @sort).merge(@gsa_filter.nil? ? {} : {:filter => @gsa_filter}).delete_if{|k,v| v.nil?}.to_query}"
    end
		alias :to_s :url

    private

    def using_google_appliance?
      !@host.nil?
    end

  end
end
