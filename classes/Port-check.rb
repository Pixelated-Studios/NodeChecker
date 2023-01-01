#!/bin/ruby
# frozen_string_literal: true

# class for checking ports
class Portch
  require_relative './Nginx-check'
  require_relative './Port-check'
  def initialize
    $instdir = '/etc/Pixelated-Studios/NodeChecker'
    $uuid = `cat /etc/uuid`.chomp
  end

  def machine_check
    puts 'Detecting Machine!'
    case $uuid
    when 'm95jnv_n5T3bmc8kmSiFSDigFTZ5UWHSkZcpWdnFdtgdkoGEvw7F7CdCK8GnrAD2'
      $nodenm = 'dragon'
      puts 'Detected Dragon!'
    when 'rCGWs2lYYrEVdD6JjaXS12bMxJf_z8KefCcoIQ4wNmRPXpgOn7HcnS_i5WnYW43A'
      $nodenm = 'gemini'
      puts 'Detected Gemini!'
    when 'wDdG98AvHFB7X1fPIUOlSlMQCLZxm3sG62SrQ1O6ZfeOrzcmYMJNBbU15DJM9WQ6'
      $nodenm = 'shuttle'
      puts 'Detected Shuttle!'
    else
      Error_handler.new('detecting node!', 'Error Code: 303')
    end
  end

  def port_type_dragon(port_type)
    case port_type
    when 1
      dragon_gather_system($nodenm)
    when 2
      dragon_gather_games($nodenm)
    else
      case port_type
      when 1
        error('executing Dragon System Port Scan!', 'Error Code: 764')
      when 2
        error('executing Dragon Games Port Scan!', 'Error Code: 765')
      else
        error('parsing an error!', 'Contact Veth/Connor, tell him you got an Error Code 1')
      end
    end
  end

  def port_type_gemini(port_type)
    case port_type
    when 1
      gemini_gather_system($nodenm)
    when 2
      gemini_gather_games($nodenm)
    else
      case port_type
      when 1
        error('executing Gemini System Port Scan!', 'Error Code: 764')
      when 2
        error('executing Gemini Games Port Scan!', 'Error Code: 765')
      else
        error('parsing an error!', 'Contact Veth/Connor, tell him you got an Error Code 1')
      end
    end
  end

  def port_type_shuttle(port_type)
    case port_type
    when 1
      Portch.shuttle_gather_system($nodenm)
    when 2
      Portch.shuttle_gather_games($nodenm)
    else
      case port_type
      when 1
        error('executing Shuttle System Port Scan!', 'Error Code: 764')
      when 2
        error('executing Shuttle Games Port Scan!', 'Error Code: 765')
      else
        error('parsing an error!', 'Contact Veth/Connor, tell him you got an Error Code 1')
      end
    end
  end

  def dir_check
    dirsreal = nil
    dirsreal = 1 if Dir.exist?($instdir)
    # if dirsreal is 1, the install directory exists
    if dirsreal == 1
      # so we run the dir_status with the 1 arg to ensure the dir isn't recreated
      dir_status(1)
      # if dirsreal doesn't equal 1, run dir_status with the 0 arg to create the working directory
    elsif dirsreal != 1 then dir_status(0)
    end
  end

  def dir_status(status)
    case status
    when 1
      puts 'Working Directory Exists!'
    when 0
      mkdirs = system(mkdir, $instdir)
      case mkdirs
      when true
        puts 'Working Directory Created!'
      when false
        Error_handler.new('while creating the working directory', 'Error Code: 662')
      when nil
        Error_handler.new('while creating the working directory', 'Error Code: 662')
      else
        Error_handler.new('while creating the working directory', 'Error Code: 662')
      end
    else
      Error_handler.new('Checking if the Working Directory exists', 'Error Code: 591')
    end
  end

  def dragon_gather_system(node_name)
    sysports1 = [2022, 8080, 30_101, 30_456, 8125, 3306]
    sysports1.each do |sysports|
      portchres = `ufw status numbered | grep -o '#{sysports}'`
      if portchres == "#{sysports}"
        Portch.dir_check
        Portch.output
      else
        Portch.error("Gathering and Testing #{node_name} System Ports",
                     'Program ran into a problem determining if ports are open! Error Code 926')
      end
    end
  end

  def dragon_gather_games(node_name)
    gmports1 = [2000..2021, 2023..3305, 3307..5000]
    gmports1.each do |gmports|
      gmportchres = `ufw status numbered | grep -o '#{gmports}'`
      if gmportchres == "#{gmports}"
        Portch.dir_check
        Portch.output
      else
        Portch.error("Gathering and Testing #{node_name} System Ports",
                     'Program ran into a problem determining if ports are open! Error Code 927')
      end
    end
  end

  def gemini_gather_system(node_name)
    sysports1 = [2022, 8080, 30_101, 30_456, 8125]
    sysports1.each do |sysports|
      portchres = `ufw status numbered | grep -o '#{sysports}'`
      if portchres == "#{sysports}"
        Portch.dir_check
        Portch.output
      else
        Portch.error("Gathering and Testing #{node_name} System Ports",
                     'Program ran into a problem determining if ports are open! Error Code 926')
      end
    end
  end

  def gemini_gather_games(node_name)
    gmports1 = [2000..2021, 2023..5000]
    gmports1.each do |gmports|
      gmportchres = `ufw status numbered | grep -o '#{gmports}'`
      if gmportchres == "#{gmports}"
        Portch.dir_check
        Portch.output
      else
        Portch.error("Gathering and Testing #{node_name} System Ports",
                     'Program ran into a problem determining if ports are open! Error Code 927')
      end
    end
  end

  def shuttle_gather_system(node_name)
    sysports1 = [2022, 8080, 30_101, 30_456, 8125]
    sysports1.each do |sysports|
      portchres = `ufw status numbered | grep -o '#{sysports}'`
      if portchres == "#{sysports}"
        Portch.dir_check
        Portch.output
      else
        Portch.error("Gathering and Testing #{node_name} System Ports",
                     'Program ran into a problem determining if ports are open! Error Code 926')
      end
    end
  end

  def shuttle_gather_games(node_name)
    gmports1 = [2000..2021, 2023..5000]
    gmports1.each do |gmports|
      gmportchres = `ufw status numbered | grep -o '#{gmports}'`
      if gmportchres == "#{gmports}"
        Portch.dir_check
        Portch.output
      else
        Portch.error("Gathering and Testing #{node_name} System Ports",
                     'Program ran into a problem determining if ports are open! Error Code 927')
      end
    end
  end
end
