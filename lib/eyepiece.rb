# frozen_string_literal: true

require_relative "eyepiece/version"
require_relative "eyepiece/search"
require_relative "eyepiece/brief"

module Eyepiece
  class Error < StandardError; end
  class TooManyRecordsError < Error; end

  # Backward-compatible aliases
  QuickSearch = Search
  QuickBriefScope = Brief
end
