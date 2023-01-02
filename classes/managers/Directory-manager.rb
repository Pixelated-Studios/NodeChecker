#!/bin/Ruby
# frozen_string_literal: true

# class for managing directories
class Directories
  require_relative '../../tests/Port-test'
  require_relative '../../tests/Nginx-test'
  require_relative '../handlers/Error-handler'
  require_relative '../system/Logman/Logman'
  attr_accessor :install_dir, :port_dir, :nginx_dir, :dirsreal, :type

  # our init method only needs to initialize the instance variables that we need to work with throughout our use
  # of this class
  def initialize
    @install_dir = '/etc/Pixelated-Studios/NodeChecker'
    @port_dir = '/etc/Pixelated-Studios/NodeChecker/tests/Port-test'
    @nginx_dir = '/etc/Pixelated-Studios/NodeChecker/tests/Nginx-test'
    # right now, this variable doesn't need to do anything. It just needs to be initialized.
    @dirsreal = nil
  end

  # here we give the directory manager the ability to test to see if directories exist
  # if you're a Ruby Developer, you're probably wondering why I don't just use the ::Dir.exist route...
  # Well, the reason is because I did. However, I wanted to keep my code looking cleaner. I'm also fairly newish to
  # the more fancy syntax things of ruby that further simplify it. So, feel free to make the changes yourself!
  # Just make sure to create a PR and explain why you made your changes, what they do differently, and how to use them
  # a docs link or use guide link would also be appreciated!
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

  # Now we actually preform our check with the 'Dir.exist?(args)' method
  def check
    @dirsreal = 1 if Dir.exist?(@directory)
    # if dirsreal is 1, the install directory exists
    case @dirsreal
    when 1
      # so we run the dir_status with the 1 arg to ensure the dir isn't recreated
      dir_status(1)
    else
      # if dirsreal doesn't equal 1, run dir_status with the 0 arg to create the working directory
      dir_status(0)
    end
  end

  # here we give the Directory Manager the ability to properly report if a directory exists back to it self so that
  # it can properly create the working directories that NodeChecker needs to operate
  def dir_status(status)
    case status
    when 1
      puts 'Working Directory Exists!'
    when 0
      # now we ask the user whether or not we even need
      # to create the working directories (In case the user has it installed somewhere custom)
      setup_make_dirs
      # now we call the method to handle the user response
      stage_make_dirs
      # now we actually create the directories we need
      make_dirs
    else
      # here we handle what happens if the system fails to check the status of the Working Directory
      # this would actually be a fatal problem normally, but just because the correct working directory
      # doesn't exist, doesn't mean this should kill the program. (In case the user is using a custom directory)
      ErrorHandler.new('error', 'Checking the Working Directory status!')
    end
  end

  # the method that actually asks the user if it needs us to create the default working directories for them
  # a user should only ever see this in the event of the system not being properly installed.
  # but it's better to just create them and check for them at each run to ensure they are there. Just in Case
  def setup_make_dirs
    puts "Working Directory Doesn't Exist!"
    puts 'Create it now? (Y/N)'
    @response = gets.chomp
  end

  # this method actually contains the logic that we use to interpret the users input we got before.
  def stage_make_dirs
    case @response.downcase
    when 'Y'
      make_dirs
    when 'N'
      nil
    else
      # this time, if the system runs into an issue, it is fatal, because the system should only attempt
      # to create it's working directory if the system wasn't installed properly or the user is using
      # a custom directory
      ErrorHandler.new('fatal', 'System ran into Error creating Working Directory!')
    end
  end

  # now we give the Directory Manager the ability to actually create directories.
  def make_dirs
    # TODO: Separate each directory with logic so the user can select which directory to create, or all
    # this is just all right now
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
