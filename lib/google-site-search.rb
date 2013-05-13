require "active_support/core_ext/object/to_query"
require "active_support/core_ext/hash/indifferent_access"
require "active_support/core_ext/object/try"
require "active_support/core_ext/object/blank"
require "google-site-search/version"
require "google-site-search/url_builder"
require "google-site-search/search"
require "google-site-search/result"
require "net/http"
require "rsmaz"
require "timeout"
require "uri"
require "xml"
require "rack/utils"

##
# A module to help query and parse the google site search api.
#
module GoogleSiteSearch
	
  GOOGLE_SEARCH_URL = "http://www.google.com"
  DEFAULT_PARAMS = {
    :client => "google-csbe",
    :output => "xml_no_dtd",
  }
  
  class Error < StandardError ; end

  class << self

    # Takes a url, strips out un-required query params, and compresses
    # a string representation. The intent is to have a small string to
    # use as a caching key. 
    def caching_key url
      params = Rack::Utils.parse_query(URI.parse(url).query)
      # ei = "Passes on an alphanumeric parameter that decodes the originating SERP where user clicked on a related search". Don't fully understand what it does but it makes my caching less effective.
      params.delete("ei") 
      key = params.map{|k,v| k.to_s + v.to_s}.sort.join
      key.blank? ? nil : RSmaz.compress(key) 
    end

    # Expects the URL returned by Search#next_results_url or Search#previous_results_url.
    def paginate url, search_engine_id
      raise GoogleSiteSearch::Error, "search_engine_id required" if search_engine_id.blank? 
      uri = URI.parse(url.to_s)
      raise GoogleSiteSearch::Error, "url seems to be invalid, parameters expected" if uri.query.blank?
      if uri.relative?
        uri.host = "www.google.com"
        uri.scheme = "http"
      end
      uri.query = uri.query += "&cx=#{search_engine_id}"
      uri.to_s
    end

    # See Search - This is a convienence method for creating and querying. 
    # This method can except a block which can access the resulting search object.
    def query url, result_class = Result, &block
      search_result = Search.new(url, result_class).query
      yield(search_result) if block_given?
      search_result
    end

    # See Search - This allows you to retrieve up to (times) number of searchs if they
    # are available (i.e. Stops if a search has no next_results_url).
    # This method can except a block which can access the resulting search object.
		def query_multiple times, url, result_class = Result, &block
			searchs = [query(url, result_class, &block).query]
			while (times=times-1) > 0
				next_results_url = searchs.last.try(:next_results_url)
        break if next_results_url.blank?
        searchs << search_result = query(url, result_class, &block).query
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
			match = /\smore(?:(?:(?::p:|:pagemap:).*\z)|(?::\w+\z))/.match(string)
			return [string, nil] if match.nil?
			return [match.pre_match.strip, match[0].strip] 
		end

  end
end
