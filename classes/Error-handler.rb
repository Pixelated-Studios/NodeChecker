#!/bin/Ruby
# frozen_string_literal: true

# Method for handling errors
class Error_handler
  require_relative './Logman'

  def initialize(severity, message)
    Logman.log_to_file(severity, message)
    Logman.log_to_stdout(severity, message)
  end
end
