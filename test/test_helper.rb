ENV['RACK_ENV'] = 'test'

require "google-site-search"
require "minitest/spec"
require "minitest/mock"
require "mocha"

#include GoogleSiteSearch #include module so I don't have to namespace everything
