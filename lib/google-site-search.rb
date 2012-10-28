require "active_support/core_ext/object/to_query"
require "active_support/core_ext/hash/indifferent_access"
require "active_support/core_ext/object/try"
require "active_support/core_ext/object/blank"
require "google-site-search/version"
require "google-site-search/url_builder"
require "google-site-search/search"
require "google-site-search/result"
require "timeout"
require "net/http"
require "uri"
require "xml"

##
# A module to help query and parse the google site search api.
#
module GoogleSiteSearch
  
	
  GOOGLE_SEARCH_URL = "http://www.google.com"
  DEFAULT_PARAMS = {
    :client => "google-csbe",
    :output => "xml_no_dtd",
  }

  class << self

    # Expects the URL returned by Search#next_results_url or Search#previous_results_url.
    def paginate url
      GOOGLE_SEARCH_URL + url.to_s
    end

    # See Search - This is a convienence method for creating and querying. 
    def query url, result_class = Result
      Search.new(url, result_class).query
    end

		def query_multiple url, result_class = Result, times
			searchs = []
			while times > 0
				times -= 1
				url = paginate(searchs.last.try(:next_results_url)) unless searchs.empty?
				searchs << Search.new(url, result_class).query
			end
			searchs
		end

    # Makes a request to the google search api and returns the xml response as a string.
    def request_xml url
      response = Net::HTTP.get_response(URI.parse(url.to_s))
			response.body if response.is_a?(Net::HTTPSuccess)
    end

    # Google returns a result link as an absolute but you may
    # want a relative version. 
    def relative_path path
      uri = URI.parse(path)
      uri.relative? ? path : [uri.path,uri.query].compact.join("?")
    end

		# Google's api will give back a full query which has the filter options on it. I like to deal with them separately so this method breaks them up.
		def separate_search_term_from_filters(string)
			match = /\smore:p.*/.match(string)
			return [string, nil] if match.nil?
			return [match.pre_match.strip, match[0].strip] 
		end

  end
end
