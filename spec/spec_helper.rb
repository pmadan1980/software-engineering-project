# SimpleCov
require "simplecov"

SimpleCov.start do
  add_filter "/spec/"
end
SimpleCov.coverage_dir "coverage"

# Sinatra App
ENV["APP_ENV"] = "test"
require_relative "../app"
def app
  Sinatra::Application
end

# Capybara
require "capybara/rspec"
Capybara.app = Sinatra::Application

# RSpec
RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Rack::Test::Methods
end

RSpec.describe String do
  describe ".strip" do
    context "when invoked on a string with leading spaces" do
      it "returns the string with the leading spaces removed" do
        expect("  hello".strip).to eq("hello")
      end
    end

    context "when invoked on a string with trailing spaces" do
      it "returns the string with the trailing spaces removed" do
        expect("hello   ".strip).to eq("hello")
      end
    end

    context "when invoked on a string with no leading or trailing spaces" do
      it "returns the same string" do
        expect("hello".strip).to eq("hello")
      end
    end
  end
end