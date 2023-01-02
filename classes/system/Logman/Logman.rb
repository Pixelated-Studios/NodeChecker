#!/bin/Ruby
# frozen_string_literal: true

# Class for handling logging
class Logman
  require 'logger'
  def initialize
    megabyte = 1024**2
    @one_hundred_megabytes = megabyte * 100
  end

  def setup_log_to_file
    @logger_file = Logger.new('checker_log.txt', 'daily', @one_hundred_megabytes)
    @logger_file.level = Logger::DEBUG
    @logger_file.datetime_format = '%m-%d-%Y %H:%M'
    @logger_file.formatter = proc { |severity, datetime, progname, msg|
      "#{severity}, #{datetime}, #{progname}, #{msg}\n"
    }
  end

  def setup_log_to_stdout
    @logger_stdout = Logger.new($stdout)
    @logger_stdout.level = Logger::DEBUG
    @logger_stdout.datetime_format = '%m-%d-%Y %H:%M'
    @logger_stdout.formatter = proc { |severity, datetime, progname, msg|
      "#{severity}, #{datetime},#{progname}, #{msg}\n"
    }
  end

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
