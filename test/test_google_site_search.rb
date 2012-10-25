require_relative 'test_helper'

describe GoogleSiteSearch do

  describe '#.relative_path' do

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
end
