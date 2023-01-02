#!/bin/Ruby
# frozen_string_literal: true

# class for managing directories
class Directories
  require_relative './Port-check'
  require_relative './Nginx-check'
  require_relative './Error-handler'
  require_relative './Logman'

  def initialize(type)
    @@instdir = '/etc/Pixelated-Studios/NodeChecker'
    @@type = case type
             when 'port'
               'port'
             when 'nginx'
               'nginx'
             else
               @@type = Error_handler.new('starting the directory manager', 'Error Code: 384')
               puts @@type
             end
  end

  def check
    dirsreal = nil
    dirsreal = 1 if Dir.exist?(@@instdir)
    # if dirsreal is 1, the install directory exists
    case dirsreal
    when 1
      # so we run the dir_status with the 1 arg to ensure the dir isn't recreated
      dir_status(1)
      # if dirsreal doesn't equal 1, run dir_status with the 0 arg to create the working directory
    else
      dir_status(0)
    end
  end

  def dir_status(status)
    case status
    when 1
      puts 'Working Directory Exists!'
    when 0
      make_dirs
    else
      Error_handler.new('Checking if the Working Directory exists', 'Error Code: 591')
    end
  end

  def make_dirs
    mkdirs = system(mkdir, @@instdir)
    case mkdirs
    when true
      puts 'Working Directory Created!'
    else
      Error_handler.new('while creating the working directory', 'Error Code: 662')
    end
  end
end
