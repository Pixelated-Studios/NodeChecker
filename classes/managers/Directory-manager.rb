#!/bin/Ruby
# frozen_string_literal: true

# class for managing directories
class Directories
  require_relative '../../tests/Port-test'
  require_relative '../../tests/Nginx-test'
  require_relative '../handlers/Error-handler'
  require_relative '../system/Logman/Logman'
  attr_accessor :install_dir, :type

  def initialize
    @install_dir = '/etc/Pixelated-Studios/NodeChecker'
    @port_dir = '/etc/Pixelated-Studios/NodeChecker/tests/Port-test'
    @nginx_dir = '/etc/Pixelated-Studios/NodeChecker/tests/Nginx-test'
    @dirsreal = nil
  end

  def setup_check(dir_to_test)
    @directory = case dir_to_test
                 when 'port'
                   @port_dir
                 when 'nginx'
                   @nginx_dir
                 when 'install'
                   @install_dir
                 else
                   ErrorHandler.new('fatal', 'System ran into issue starting the directory manager')
                 end
  end

  def check
    @dirsreal = 1 if Dir.exist?(@directory)
    # if dirsreal is 1, the install directory exists
    case @dirsreal
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
      setup_make_dirs
      stage_make_dirs
      make_dirs
    else
      ErrorHandler.new('fatal', 'Checking the Working Directory status!')
    end
  end

  def setup_make_dirs
    puts "Working Directory Doesn't Exist!"
    puts 'Create it now? (Y/N)'
    @response = gets.chomp
  end

  def stage_make_dirs
    case @response.downcase
    when 'Y'
      make_dirs
    when 'N'
      nil
    else
      ErrorHandler.new('fatal', 'System ran into Error creating Working Directory!')
    end
  end

  def make_dirs
    make_install_dir = system(mkdir, @install_dir)
    make_install_dir_result = make_install_dir
    Logman.log_to_stdout('info', 'Install Directory Created!') if make_install_dir_result
    make_port_dir = system(mkdir, @port_dir)
    make_port_dir_result = make_port_dir
    Logman.log_to_stdout('info', 'Port Directory Created!') if make_port_dir_result
    make_nginx_dir = system(mkdir, @nginx_dir)
    make_nginx_dir_result = make_nginx_dir
    Logman.log_to_stdout('info', 'Nginx Directory Created!') if make_nginx_dir_result
  end
end
