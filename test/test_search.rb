require_relative 'test_helper'

describe Search do

  let :xml do
    IO.read(File.join(File.dirname(__FILE__), "data", "utf8_results.xml"))
  end

  describe "#query" do
    
    let :search do
      GoogleSiteSearch.stub(:request_xml, xml) do
        Search.new("/sample", Result).query 
      end
    end

    it "stores the original url given" do
      search.url.must_equal "/sample"
    end

    it "has the two results from our xml example" do
      search.results.count.must_equal 2
    end

    it "contains the estimated results total" do
      search.estimated_results_total.must_equal "29"
    end

    it "contains the next results url" do
      search.next_results_url.wont_be :empty?
    end

    it "next results url removed the search engine id parameter" do
      search.next_results_url.must_equal "/next?q=search&start=1"
    end

    it "contains the previous results url" do
      search.previous_results_url.wont_be :empty?
    end

    it "next results url removed the search engine id parameter" do
      search.previous_results_url.must_equal "/previous?q=search&start=20"
    end
    
    it "stores the original xml" do
      search.xml.must_equal xml
    end
    
    it "defaults to the Result class" do
      search.result_class.must_equal Result
    end

    it "stores the original search query" do
      search.search_query.must_equal "rails"
    end

    it "contains the spelling suggestion" do
      search.spelling.must_equal "fake suggestion not escaped"
    end

    it "contains the spelling suggestion attribute q" do
      search.spelling_q.must_equal "fake suggestion escaped"
    end
  end

end
