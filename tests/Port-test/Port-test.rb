#!/bin/ruby
# frozen_string_literal: true

# class for checking ports
class PortCheck
  require_relative '../Nginx-test'
  require_relative '../../classes/managers/Directory-manager'
  require_relative '../../classes/handlers/Error-handler'
  require_relative '../../classes/system/util/Machine-UUID-check'
  require_relative '../../classes/system/Logman/Logman'
  attr_accessor :install_dir

  def initialize
    Directories.new
    MachineChecker.new
  end

  def port_error_handler(port_type)
    case port_type
    when 1
      ErrorHandler.new('fatal', "Failure executing #{@nodenm} System Ports Scan!")
    when 2
      ErrorHandler.new('fatal', "Failure executing #{@nodenm} Games Ports Scan!")
    else
      ErrorHandler.new('fatal',
                       'There was an error parsing an error! Contact Veth/Connor, tell him you got an Error Code 1')
    end
  end

  def port_type_dragon(port_type)
    case port_type
    when 1
      setup_dragon_gather_system
    when 2
      setup_dragon_gather_games
    else
      port_error_handler(port_type)
    end
  end

  def port_type_gemini(port_type)
    case port_type
    when 1
      setup_gemini_gather_system
    when 2
      setup_gemini_gather_games
    else
      port_error_handler(port_type)
    end
  end

  def port_type_shuttle(port_type)
    case port_type
    when 1
      setup_shuttle_gather_system
    when 2
      setup_shuttle_gather_games
    else
      port_error_handler(port_type)
    end
  end

  def output_portcheck_results
    p 'outputting'
  end

  def setup_dragon_gather_system
    sysports1 = [2022, 8080, 30_101, 30_456, 8125, 3306]
    sysports1.each do |sysports|
      @portchres = `ufw status numbered | grep -o '#{sysports}'`
      dragon_gather_system(sysports)
    end
  end

  def dragon_gather_system(sysports)
    if @portchres == sysports.to_s
      Directories.setup_check('port')
      Directories.check
      output_portcheck_results
    else
      port_error_handler(1)
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
