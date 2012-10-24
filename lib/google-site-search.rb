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

    # expects the url returned by Search next_results_url/previous_results_url
    def paginate url
      GOOGLE_SEARCH_URL + url.to_s
    end

    # makes a request to the google search api and populates a _Search_ object with the results. The search object will parse out various 
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

    # makes a request to the google search api and returns the xml response as a string.
    def request_xml url
			response = nil
      begin
        ::Timeout::timeout(2) do
          response = Net::HTTP.get_response(URI.parse(url.to_s))
        end
      rescue Errno::ECONNREFUSED => err
			rescue URI::InvalidURIError => err
				puts "URI Error [#{url}]"
      rescue => err
     	  puts "ERROR #{err.class}"  
      end
			response.body if response && response.code == "200"
    end

		# google's api will give back a full query which has the filter options on it. I like to deal with them separately so this method breaks them up.
		def separate_search_term_from_filters(string)
			match = /\smore:p.*/.match(string)
			return [string, nil] if match.nil?
			return [match.pre_match, match[0]] 
		end
  end
end
