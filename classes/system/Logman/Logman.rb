#!/bin/Ruby
# frozen_string_literal: true

# Class for handling logging
class Logman
  require 'logger'
  # our init method largely just needs to tell Logger how big we want the maximum logfile size to be
  # so, we just do some quick math
  def initialize
    megabyte = 1024**2
    @one_hundred_megabytes = megabyte * 100
  end

  # now we prepare Logman to actually put our logs into the file we want, with the format we want.
  # what this actually tells Logman to do, is tell it to create a new log every day, or multiple logs in one day
  # should the log file exceed 100 megabytes. This should help with preventing logs from taking up huge amounts
  # of space on the system. We also change the format of Logman's output to be better looking (in my opinion)
  def setup_log_to_file
    @logger_file = Logger.new('checker_log.txt', 'daily', @one_hundred_megabytes)
    @logger_file.level = Logger::DEBUG
    @logger_file.datetime_format = '%m-%d-%Y %H:%M'
    @logger_file.formatter = proc { |severity, datetime, progname, msg|
      "#{severity}, #{datetime}, #{progname}, #{msg}\n"
    }
  end

  # we do everything we did about for logging out to a file, but for logging out to STDOUT for the Terminal User
  # to actually see in a more "Verbose" fashion
  def setup_log_to_stdout
    @logger_stdout = Logger.new($stdout)
    @logger_stdout.level = Logger::DEBUG
    @logger_stdout.datetime_format = '%m-%d-%Y %H:%M'
    @logger_stdout.formatter = proc { |severity, datetime, progname, msg|
      "#{severity}, #{datetime},#{progname}, #{msg}\n"
    }
  end

  # Now we setup how to actually print out with Logman. The actual calling of this method happens in the
  # error handler. This was setup so that we an work with errors and such before they reach the log if
  # we should need to.
  def log_to_file(severity, message)
    case severity
    when 'debug' then @logger_file.debug(message)
    when 'info' then @logger_file.info(message)
    when 'warn' then @logger_file.warn(message)
    when 'error' then @logger_file.error(message)
    else Logger.fatal(message)
    end
  end

  def log_to_stdout(severity, message)
    case severity
    when 'debug' then @logger_stdout.debug(message)
    when 'info' then @logger_stdout.info(message)
    when 'warn' then @logger_stdout.warn(message)
    when 'error' then @logger_stdout.error(message)
    else Logger.fatal(message)
    end
  end
end
