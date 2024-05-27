# frozen_string_literal: true

require File.expand_path('./vcr_config', __dir__)

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'simplecov'
require 'simplecov-lcov'

require_relative '../lib/yandex_disk'

YANDEX_DISK_TOKEN = ENV['YANDEX_DISK_TOKEN'] || 'your_own_access_token'

SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
SimpleCov.formatter = SimpleCov::Formatter::LcovFormatter

SimpleCov.start do
  add_filter 'spec/'
  add_group 'Lib', 'lib'
  minimum_coverage 80.0
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
