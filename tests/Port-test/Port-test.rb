#!/bin/ruby
# frozen_string_literal: true

# class for checking ports
class PortCheck
  require_relative '../Nginx-test'
  require_relative '../../classes/managers/Directory-manager'
  require_relative '../../classes/handlers/Error-handler'
  require_relative '../../classes/system/util/Machine-UUID-check'
  require_relative '../../classes/system/Logman/Logman'
  # attr_accessor for @install_dir so we can read it globally from other classes and methods
  attr_accessor :install_dir

  # make the init method start up the directory manager and the machine checker in prep for operating with them
  def initialize
    Directories.new
    MachineChecker.new
  end

  # create some brief logic for the port class to return proper results to the ErrorHandler
  # I might add some logic to the ErrorHandler directly later to handle the port checker specifically
  # but for now this works
  def port_error_handler(port_type)
    case port_type
    when 1
      ErrorHandler.new('error', "Failure executing #{@nodenm} System Ports Scan!")
    when 2
      ErrorHandler.new('error', "Failure executing #{@nodenm} Games Ports Scan!")
    else
      ErrorHandler.new('fatal',
                       'There was a critical error parsing an error! Contact Veth/Connor,
 tell him you got an Error Code 1')
    end
  end

  # the method for handling ports for the Dragon Node in the OrbitNode Network
  def port_type_dragon(port_type)
    case port_type
    when 1
      # run the setup system for the port test for the Dragon node, which automatically runs the port test
      setup_dragon_gather_system
    when 2
      setup_dragon_gather_games
    else
      port_error_handler(port_type)
    end
  end

  # the method for handling ports for the Gemini Node in the OrbitNode Network
  def port_type_gemini(port_type)
    case port_type
    when 1
      # run the setup system for the port test for the Gemini node, which automatically runs the port test
      setup_gemini_gather_system
    when 2
      setup_gemini_gather_games
    else
      port_error_handler(port_type)
    end
  end

  # the method for handling ports for the Shuttle Node in the OrbitNode Network
  def port_type_shuttle(port_type)
    case port_type
    when 1
      # run the setup system for the port test for the Shuttle node, which automatically runs the port test
      setup_shuttle_gather_system
    when 2
      setup_shuttle_gather_games
    else
      port_error_handler(port_type)
    end
  end

  # Method for outputting the final results of the Port Test
  def output_portcheck_results(result)
    Logman.log_to_stdout('info', result.to_s)
    Logman.log_to_file('info', result.to_s)
    @logger_stdout.info(result.to_s) | File.write('../../classes/system/Logman/portcheck_results.txt', mode: 'a')
  end

  # setup the test on Dragons System Ports.
  def setup_dragon_gather_system
    # set up a variable as an array of integers (we separate big numbers with the underscores to make Ruby happier)
    sysports1 = [2022, 8080, 30_101, 30_456, 8125, 3306]
    # now we take each of those numbers and put them into a variable
    sysports1.each do |sysports|
      # the 'sysports' variable will hold onto the current number until the below runs
      # the line below will only work with UFW currently, however, I do plan to expand out with
      # and additional staging process earlier in this process that will detect the firewall being used
      @portchres = `ufw status numbered | grep -o '#{sysports}'`
      dragon_gather_system(sysports)
    end
  end

  # now let's actually gather the port test results
  def dragon_gather_system(sysports)
    # here we check if the output matches the port we want. If the port is closed,
    if @portchres == sysports.to_s
      # first thing first, let's make sure the directory we need exists
      Directories.setup_check('port')
      Directories.check
      # after the check is complete, we can print success!
      output_portcheck_results("Port #{sysports} is open!")
    else
      # if the port is anything other than what we want, that means the port is closed
      puts "Port #{sysports} closed!"
    end
  end
end

def setup_dragon_gather_games
  gmports1 = [2000..2021, 2023..3305, 3307..5000]
  gmports1.each do |gmports|
    @gmportchres = `ufw status numbered | grep -o '#{gmports}'`
    dragon_gather_games(gmports)
  end
end

def dragon_gather_games(gmports)
  if @gmportchres == gmports.to_s
    Directories.setup_check('port')
    Directories.check
    output_portcheck_results
  else
    port_error_handler(2)
  end
end

def setup_gemini_gather_system
  sysports1 = [2022, 8080, 30_101, 30_456, 8125]
  sysports1.each do |sysports|
    @portchres = `ufw status numbered | grep -o '#{sysports}'`
    gemini_gather_system(sysports)
  end
end

def gemini_gather_system(sysports)
  if @portchres == sysports.to_s
    Directories.setup_check('port')
    Directories.check
    output_portcheck_results
  else
    port_error_handler(1)
  end
end

def setup_gemini_gather_games
  gmports1 = [2000..2021, 2023..5000]
  gmports1.each do |gmports|
    @gmportchres = `ufw status numbered | grep -o '#{gmports}'`
    gemini_gather_games(gmports)
  end
end

def gemini_gather_games(gmports)
  if @gmportchres == gmports.to_s
    Directories.setup_check('port')
    Directories.check
    output_portcheck_results
  else
    port_error_handler(2)
  end
end

def setup_shuttle_gather_system
  sysports1 = [2022, 8080, 30_101, 30_456, 8125]
  sysports1.each do |sysports|
    @portchres = `ufw status numbered | grep -o '#{sysports}'`
    shuttle_gather_system(sysports)
  end
end

def shuttle_gather_system(sysports)
  if @portchres == sysports.to_s
    Directories.setup_check('port')
    Directories.check
    output_portcheck_results
  else
    port_error_handler(1)
  end
end

def setup_shuttle_gather_games
  gmports1 = [2000..2021, 2023..5000]
  gmports1.each do |gmports|
    @gmportchres = `ufw status numbered | grep -o '#{gmports}'`
    shuttle_gather_games(gmports)
  end
end

def shuttle_gather_games(gmports)
  if @gmportchres == gmports.to_s
    Directories.setup_check('port')
    Directories.check
    output_portcheck_results
  else
    port_error_handler(2)
  end
end
