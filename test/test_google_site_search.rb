require_relative 'test_helper'

describe GoogleSiteSearch do

  describe '.paginate' do
    it 'completes a valid url for the relative path supplied' do
      GoogleSiteSearch.paginate("/some/path").must_equal "http://www.google.com/some/path"
    end
  end

  describe '.relative_path' do
    it 'raises InvalidURLError if a nil is given' do
      -> {GoogleSiteSearch.relative_path(nil)}.must_raise URI::InvalidURIError
    end

    describe 'given a relative path' do
      it 'returns the path given' do
        GoogleSiteSearch.relative_path("/somepath").must_equal "/somepath" 
      end
      
    end 

    describe 'given an absolute url' do 
      it 'with just the domain a root path will be returned' do
        GoogleSiteSearch.relative_path("http://www.somesite.com/").must_equal "/" 
      end

      it 'with a domain and path given the path will be returned' do
        GoogleSiteSearch.relative_path("http://www.somesite.com/my-test").must_equal "/my-test" 
      end

      it 'with a query string the path and query will be returned' do
        GoogleSiteSearch.relative_path("http://www.somesite.com/my-test?something=value").must_equal "/my-test?something=value" 
      end

    end
  end

  describe '.separate_search_term_from_filters' do

    it 'works on a valid search and filter' do
      GoogleSiteSearch.separate_search_term_from_filters("microsoft more:pagemap:mytype").must_equal ["microsoft", "more:pagemap:mytype"]
    end

    it 'not fooled by an improper filter' do
      GoogleSiteSearch.separate_search_term_from_filters("microsoft more:x:wrong").must_equal ["microsoft more:x:wrong", nil]
    end

    it 'strips whitespace' do
      GoogleSiteSearch.separate_search_term_from_filters(" microsoft  more:p:my-value  ").must_equal ["microsoft", "more:p:my-value"]
    end

    it 'handles nil' do
      GoogleSiteSearch.separate_search_term_from_filters(nil).must_equal [nil, nil]
    end

    it 'handles ""' do
      GoogleSiteSearch.separate_search_term_from_filters("").must_equal ["", nil]
    end
  end

  describe ".request_xml" do

    it "passes back the body of a successfull HTTP request" do
      mock = MiniTest::Mock.new.expect(:is_a?, true, [Net::HTTPSuccess])
        .expect(:body, "my response")
      Net::HTTP.stub(:get_response, mock) do
       GoogleSiteSearch.request_xml("/doesnt_matter").must_equal "my response" 
      end
    end

    it "returns nil if not a Net::HTTPSuccess" do
      mock = MiniTest::Mock.new.expect( :is_a?, false, [Net::HTTPSuccess])
      Net::HTTP.stub(:get_response, mock) do
       GoogleSiteSearch.request_xml("/doesnt_matter").must_be_nil
      end
    end

    it "doesn't catch exceptions if they happen" do
      mock = -> a {raise StandardError}
      Net::HTTP.stub(:get_response, mock) do
       -> {GoogleSiteSearch.request_xml("/doesnt_matter")}.must_raise StandardError 
      end
    end
  end

end
