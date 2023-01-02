#!/bin/Ruby
# frozen_string_literal: true

# Method for handling errors
class Error_handler
  require_relative './Nginx-check'
  require_relative './Port-check'
  require_relative './Logman'

  def initialize(method, status)
    logger"System ran into an issue while #{method}"
    puts "#{status}"
  end
end
