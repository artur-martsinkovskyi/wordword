# frozen_string_literal: true

require "wordword/version"

module Wordword
  class Error < StandardError; end
  Dir[File.join(File.dirname(__FILE__), "initializers", "*")].map { |f| require f }
  # Your code goes here...
end
