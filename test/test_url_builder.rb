require_relative 'test_helper'

describe UrlBuilder do
	it "#initialize expects valid arguments" do
		-> {GoogleSiteSearch::UrlBuilder.new(nil, nil)}.must_raise ArgumentError
		-> {GoogleSiteSearch::UrlBuilder.new("","")}.must_raise ArgumentError
		-> {GoogleSiteSearch::UrlBuilder.new("string", nil)}.must_raise ArgumentError
		-> {GoogleSiteSearch::UrlBuilder.new(nil, "string")}.must_raise ArgumentError
		GoogleSiteSearch::UrlBuilder.new("string", "string").must_be_instance_of UrlBuilder
	end

end

