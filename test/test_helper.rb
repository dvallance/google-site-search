ENV['RACK_ENV'] = 'test'

require "google-site-search"
#require "test/unit"
require "minitest/spec"
include GoogleSiteSearch #include module so I don't have to namespace everything
