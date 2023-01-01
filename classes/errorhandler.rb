#!/bin/Ruby
# frozen_string_literal: true

# Method for handling errors
class Error_handler
  require_relative './Nginx-check'
  require_relative './Port-check'
  def initialize(method, status)
    puts "System ran into an issue while #{method}"
    puts "#{status}"
  end
end
