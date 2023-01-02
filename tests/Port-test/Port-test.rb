#!/bin/ruby
# frozen_string_literal: true

# class for checking ports
class Port_check
  require_relative '../Nginx-test'
  require_relative '../../classes/managers/Directory-manager'
  require_relative '../../classes/handlers/Error-handler'
  require_relative '../../classes/system/util/Machine-UUID-check'
  require_relative '../../classes/system/Logman/Logman'
  attr_accessor :instdir

  def initialize
    @instdir = '/etc/Pixelated-Studios/NodeChecker'
    MachineChecker.new
  end

  def port_error_handler(port_type)
    case port_type
    when 1
      Error_handler.new('fatal', "Failure executing #{@nodenm} System Ports Scan!")
    when 2
      Error_handler.new('fatal', "Failure executing #{@nodenm} Games Ports Scan!")
    else
      Error_handler.new('fatal',
                        'There was an error parsing an error! Contact Veth/Connor, tell him you got an Error Code 1')
    end
  end

  def port_type_dragon(port_type)
    case port_type
    when 1
      dragon_gather_system(@nodenm)
    when 2
      dragon_gather_games(@nodenm)
    else
      port_error_handler(port_type)
    end
  end

  def port_type_gemini(port_type)
    case port_type
    when 1
      gemini_gather_system(@nodenm)
    when 2
      gemini_gather_games(@nodenm)
    else
      port_error_handler(port_type)
    end
  end

  def port_type_shuttle(port_type)
    case port_type
    when 1
      Port_check.shuttle_gather_system(@nodenm)
    when 2
      Port_check.shuttle_gather_games(@nodenm)
    else
      port_error_handler(port_type)
    end
  end

  def output
    p 'outputting'
  end

  def dragon_gather_system(node_name)
    sysports1 = [2022, 8080, 30_101, 30_456, 8125, 3306]
    sysports1.each do |sysports|
      portchres = `ufw status numbered | grep -o '#{sysports}'`
      if portchres == sysports.to_s
        Port_check.dir_check
        Port_check.output
      else
        Port_check.error("Gathering and Testing #{node_name} System Ports",
                         'Program ran into a problem determining if ports are open! Error Code 926')
      end
    end
  end

  def dragon_gather_games(node_name)
    gmports1 = [2000..2021, 2023..3305, 3307..5000]
    gmports1.each do |gmports|
      gmportchres = `ufw status numbered | grep -o '#{gmports}'`
      if gmportchres == gmports.to_s
        Port_check.dir_check
        Port_check.output
      else
        Port_check.error("Gathering and Testing #{node_name} System Ports",
                         'Program ran into a problem determining if ports are open! Error Code 927')
      end
    end
  end

  def gemini_gather_system(node_name)
    sysports1 = [2022, 8080, 30_101, 30_456, 8125]
    sysports1.each do |sysports|
      portchres = `ufw status numbered | grep -o '#{sysports}'`
      if portchres == sysports.to_s
        Port_check.dir_check
        Port_check.output
      else
        Port_check.error("Gathering and Testing #{node_name} System Ports",
                         'Program ran into a problem determining if ports are open! Error Code 926')
      end
    end
  end

  def gemini_gather_games(node_name)
    gmports1 = [2000..2021, 2023..5000]
    gmports1.each do |gmports|
      gmportchres = `ufw status numbered | grep -o '#{gmports}'`
      if gmportchres == gmports.to_s
        Port_check.dir_check
        Port_check.output
      else
        Port_check.error("Gathering and Testing #{node_name} System Ports",
                         'Program ran into a problem determining if ports are open! Error Code 927')
      end
    end
  end

  def shuttle_gather_system(node_name)
    sysports1 = [2022, 8080, 30_101, 30_456, 8125]
    sysports1.each do |sysports|
      portchres = `ufw status numbered | grep -o '#{sysports}'`
      if portchres == sysports.to_s
        Port_check.dir_check
        Port_check.output
      else
        Port_check.error("Gathering and Testing #{node_name} System Ports",
                         'Program ran into a problem determining if ports are open! Error Code 926')
      end
    end
  end

  def shuttle_gather_games(node_name)
    gmports1 = [2000..2021, 2023..5000]
    gmports1.each do |gmports|
      gmportchres = `ufw status numbered | grep -o '#{gmports}'`
      if gmportchres == gmports.to_s
        Port_check.dir_check
        Port_check.output
      else
        Port_check.error("Gathering and Testing #{node_name} System Ports",
                         'Program ran into a problem determining if ports are open! Error Code 927')
      end
    end
  end
end
