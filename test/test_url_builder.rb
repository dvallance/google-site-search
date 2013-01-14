require_relative 'test_helper'

describe GoogleSiteSearch::UrlBuilder do
	it "#initialize expects valid arguments" do
		-> {GoogleSiteSearch::UrlBuilder.new(nil, nil)}.must_raise ArgumentError
		-> {GoogleSiteSearch::UrlBuilder.new("","")}.must_raise ArgumentError
		-> {GoogleSiteSearch::UrlBuilder.new("string", nil)}.must_raise ArgumentError
		-> {GoogleSiteSearch::UrlBuilder.new(nil, "string")}.must_raise ArgumentError
		GoogleSiteSearch::UrlBuilder.new("string", "string").must_be_instance_of GoogleSiteSearch::UrlBuilder
  end

  it "properly determines and sets a host" do
    GoogleSiteSearch::UrlBuilder.new("test", "http://something").host.must_equal "http://something"
  end

  it "properly determines and sets the search_engine_id" do
    GoogleSiteSearch::UrlBuilder.new("test", "my_key").search_engine_id.must_equal "my_key"
  end

  describe "builds url as expected" do

    it "when providing a valid host (e.g. http:://...)" do
      GoogleSiteSearch::UrlBuilder.new("test", "http://my_google_appliance").to_s.must_equal "http://my_google_appliance?client=default_frontend&filter=p&output=xml_no_dtd&q=test"
    end

    it "when providing a search engine id" do
      GoogleSiteSearch::UrlBuilder.new("test", "my_key").to_s.must_equal "http://www.google.com/cse?client=google-csbe&cx=my_key&output=xml_no_dtd&q=test"
    end

    it "when I override one of the defaults with host" do
      GoogleSiteSearch::UrlBuilder.new("test", "http://test", :client => "client").to_s.must_equal "http://test?client=client&filter=p&output=xml_no_dtd&q=test"
    end

    it "when I override one of the defaults with search_engine_key" do
      GoogleSiteSearch::UrlBuilder.new("test", "my_key", :client => "client").to_s.must_equal "http://www.google.com/cse?client=client&cx=my_key&output=xml_no_dtd&q=test"
    end

    it "when I override filter for a host supplied builder" do
      GoogleSiteSearch::UrlBuilder.new("test", "http://host", :gsa_filter => :"1").to_s.must_equal "http://host?client=default_frontend&filter=1&output=xml_no_dtd&q=test"
    end

	end

end

