require_relative 'test_helper'

describe Search do

  let :xml do
    <<-xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<GSP VER="3.2">
<TM>0.075037</TM><Q>rails</Q>
<PARAM name="q" value="rails" original_value="rails" url_escaped_value="rails" js_escaped_value="rails"></PARAM><PARAM name="num" value="2" original_value="2" url_escaped_value="2" js_escaped_value="2"></PARAM><PARAM name="hl" value="en" original_value="en" url_escaped_value="en" js_escaped_value="en"></PARAM><PARAM name="client" value="google-csbe" original_value="google-csbe" url_escaped_value="google-csbe" js_escaped_value="google-csbe"></PARAM><PARAM name="cx" value="009797329687680929468:y_saholjpsk" original_value="009797329687680929468:y_saholjpsk" url_escaped_value="009797329687680929468%3Ay_saholjpsk" js_escaped_value="009797329687680929468:y_saholjpsk"></PARAM><PARAM name="boostcse" value="0" original_value="0" url_escaped_value="0" js_escaped_value="0"></PARAM><PARAM name="output" value="xml_no_dtd" original_value="xml_no_dtd" url_escaped_value="xml_no_dtd" js_escaped_value="xml_no_dtd"></PARAM><PARAM name="ie" value="UTF-8" original_value="UTF-8" url_escaped_value="UTF-8" js_escaped_value="UTF-8"></PARAM><PARAM name="oe" value="UTF-8" original_value="UTF-8" url_escaped_value="UTF-8" js_escaped_value="UTF-8"></PARAM><PARAM name="prmd" value="ivnslb" original_value="ivnslb" url_escaped_value="ivnslb" js_escaped_value="ivnslb"></PARAM><PARAM name="ei" value="PYSNUNWAKKea2AXH0YDYDA" original_value="PYSNUNWAKKea2AXH0YDYDA" url_escaped_value="PYSNUNWAKKea2AXH0YDYDA" js_escaped_value="PYSNUNWAKKea2AXH0YDYDA"></PARAM><PARAM name="start" value="2" original_value="2" url_escaped_value="2" js_escaped_value="2"></PARAM><PARAM name="sa" value="N" original_value="N" url_escaped_value="N" js_escaped_value="N"></PARAM><SEARCH_MODES><PROMOTED_MODES></PROMOTED_MODES><UNPROMOTED_MODES></UNPROMOTED_MODES><MORE_TEXT>More</MORE_TEXT><LESS_TEXT>Fewer</LESS_TEXT></SEARCH_MODES><Spelling><Suggestion q="fake suggestion escaped">fake suggestion not escaped</Suggestion></Spelling><Context><title>Info-Tech Research Group</title><Facet><FacetItem><label>test_refinement</label><anchor_text>Test Refinement</anchor_text></FacetItem></Facet></Context><RES SN="3" EN="4">
it "contains the spelling suggestions" do

end
<M>29</M>
<NB><PU>/previous</PU><NU>/next</NU></NB>
<RG START="1" SIZE="2"></RG> <RG START="1" SIZE="1">    </RG> <R N="3"><U>http://www.infotech.com/research/web-app-dev-trade-in-j2ee-for-ruby-on-rails</U><UE>http://www.infotech.com/research/web-app-dev-trade-in-j2ee-for-ruby-on-rails</UE><T>Web App Dev: Trade in J2EE for Ruby on &lt;b&gt;Rails&lt;/b&gt; | Info-Tech Research &lt;b&gt;...&lt;/b&gt;</T><RK>0</RK><BYLINEDATE>1144738800</BYLINEDATE><S>11 Apr 2006 &lt;b&gt;...&lt;/b&gt; Ruby is gaining a lot of attention as more Web developers report shorter learning &lt;br&gt;  curves and development cycles using the language.</S><LANG>en</LANG><Label>_cse_y_saholjpsk</Label><PageMap><DataObject type="metatags"><Attribute name="viewport" value="width=device-width, initial-scale=1.0"/><Attribute name="csrf-param" value="authenticity_token"/><Attribute name="csrf-token" value="33G4AEWugnU0gp6lDmF/Ct527Yi16df7TR3qST8t52I="/><Attribute name="product" value="itap|"/><Attribute name="product_slug" value="web-app-dev-trade-in-j2ee-for-ruby-on-rails"/><Attribute name="publicationtype" value="note"/><Attribute name="lifecycle" value="MakeDecisions|Evaluate|"/><Attribute name="categories" value="|applications|application-web-development-maintenance|development|"/><Attribute name="publishdate" value="2006-04-11"/><Attribute name="authors" value="Curtis Gittens|"/><Attribute name="title" value="Web App Dev: Trade in J2EE for Ruby on Rails"/></DataObject></PageMap><HAS><L/><C SZ="40k" CID="6P9DT50RDYIJ"/><RT/></HAS></R>
  <RG START="2" SIZE="1">    </RG> <R N="4"><U>http://hr.mcleanco.com/research/hr-craft-effective-performance-improvement-plans</U><UE>http://hr.mcleanco.com/research/hr-craft-effective-performance-improvement-plans</UE><T>Implement Performance Improvement Plans | McLean &amp;amp; Company</T><RK>0</RK><BYLINEDATE>1313996400</BYLINEDATE><S>22 Aug 2011 &lt;b&gt;...&lt;/b&gt; 1. Implement Performance Improvement Plans. Get employee performance on &lt;br&gt;  track before it rides off the &lt;b&gt;rails&lt;/b&gt;. McLean &amp;amp; Company. / 12. 00:00 &lt;b&gt;...&lt;/b&gt;</S><LANG>en</LANG><Label>_cse_y_saholjpsk</Label><PageMap><DataObject type="publication"><Attribute name="type">solution-set</Attribute><Attribute name="type-title">Solution Set</Attribute><Attribute name="attachment-icons">http://static.infotech.com/images/css/icons/ppt_icon-14x14.png|http://static.infotech.com/images/css/icons/doc_icon-14x14.png</Attribute><Attribute name="product_type_bias">1</Attribute><Attribute name="product_families">hr</Attribute><Attribute name="slug">hr-craft-effective-performance-improvement-plans</Attribute><Attribute name="categories">talent-management|coaching-and-development</Attribute><Attribute name="publishdate">2011-05-26</Attribute><Attribute name="authors">Susanna Hunter</Attribute><Attribute name="title">Implement Performance Improvement Plans</Attribute><Attribute name="description">Managers dread implementing a Performance Improvement Plan (PIP) because they think it&#39;s a waste of time. However, in a recent McLean &amp; Company survey, 68% of employees who were placed on a PIP were still with the organization. When a manager...</Attribute><Attribute name="keywords">performance management|Development|difficult employee|performance review|discrimination|termination|Coaching|poor performance|employee performance|Performance Improvement Plan|PIP|performance improvement|Performance appraisal|corrective action|development plans|corrective discipline|progressive discipline|performance issue</Attribute></DataObject><DataObject type="metatags"><Attribute name="viewport" value="width=device-width, initial-scale=1.0"/><Attribute name="csrf-param" value="authenticity_token"/><Attribute name="csrf-token" value="9UbBckKIdrtN7Gn8ZFSuhOqvTcY/8JzUW34mXU4Cwiw="/><Attribute name="product" value="hr|"/><Attribute name="product_slug" value="hr-craft-effective-performance-improvement-plans"/><Attribute name="publicationtype" value="solution-set"/><Attribute name="categories" value="|talent-management|coaching-and-development|"/><Attribute name="publishdate" value="2011-05-26"/><Attribute name="authors" value="Susanna Hunter|"/><Attribute name="title" value="Implement Performance Improvement Plans"/></DataObject><DataObject type="cse_image"><Attribute name="src" value="http://static.infotech.com/images/MCO-Thumb-SB6.jpg"/></DataObject><DataObject type="cse_thumbnail"><Attribute name="width" value="280"/><Attribute name="height" value="160"/><Attribute name="src" value="http://t1.gstatic.com/images?q=tbn:ANd9GcSC2UdC2eeAKKC4nh_iWK8oiPjMI06QVKIKUgSwi3VbnlBEI4TmjiaG12IU"/></DataObject></PageMap><HAS><L/><C SZ="85k" CID="ffPBTuMTrTIJ"/><RT/></HAS></R>
 <RHS_COLUMN><RG START="1" SIZE="0"></RG></RHS_COLUMN></RES>
</GSP>
xml

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
      search.next_results_url.must_equal "/next"
    end

    it "contains the previous results url" do
      search.previous_results_url.must_equal "/previous"
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
