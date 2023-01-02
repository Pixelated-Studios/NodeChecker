#!/bin/Ruby
# frozen_string_literal: true

# Method for handling errors
class ErrorHandler
  require_relative '../system/Logman'

  # setup the initialize method. We can use this method to do
  # both logging out to stdout and to file at the same time with a single method call.
  # I might expand out the ErrorHandler with it's own logic later. But for now, this
  # rudimentary implementation works
  def initialize(severity, message)
    Logman.log_to_file(severity, message)
    Logman.log_to_stdout(severity, message)
  end
end
