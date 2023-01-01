#!/bin/ruby
# frozen_string_literal: true

require_relative './classes/Nginx-check'
require_relative './classes/Port-check'
require_relative './classes/errorhandler'
require_relative './Gemfile'

two_lines = RubyFiglet::Figlet.new("Pixelated\nNodeCheck")
two_lines.show
sleep(2)
puts 'Checking NGINX status'
Nginxch.new
if ($nginxstatus = 0)
  puts 'Checking Ports!'
  sleep(1)
  Portch.new
else
  puts 'Previous test failed, Skipping!'
  sleep(1)
end

puts 'Would you like to test ports for this node? (Y/N)'
resp1 = gets.chomp
case resp1
when 'Y'
  Portch.new
  Portch.machine_check
  puts 'Do you want to test Games or Systems ports? (G/S)'
  resp2 = gets.chomp
  case resp2
  when 'S'
    case $nodenm
    when 'dragon'
      Portch.port_type_dragon(1)
    when 'gemini'
      Portch.port_type_gemini(1)
    when 'shuttle'
      Portch.port_type_shuttle(1)
    else
      Error_handler.new('Running the Systems Port Check', 'Error Code: 287')
    end
  when 's'
    case $nodenm
    when 'dragon'
      Portch.port_type_dragon(1)
    when 'gemini'
      Portch.port_type_gemini(1)
    when 'shuttle'
      Portch.port_type_shuttle(1)
    else
      Error_handler.new('Running the Systems Port Check', 'Error Code: 287')
    end
  when 'G'
    case $nodenm
    when 'dragon'
      Portch.port_type_dragon(2)
    when 'gemini'
      Portch.port_type_gemini(2)
    when 'shuttle'
      Portch.port_type_shuttle(2)
    else
      Error_handler.new('Running the Games Port Check', 'Error Code: 287')
    end
  when 'g'
    case $nodenm
    when 'dragon'
      Portch.port_type_dragon(2)
    when 'gemini'
      Portch.port_type_gemini(2)
    when 'shuttle'
      Portch.port_type_shuttle(2)
    else
      Error_handler.new('Running the Port Check', 'Error Code: 287')
    end
  else
    Error_handler.new('running the Port Check', 'Error Code: 287')
  end
when 'y'
  Portch.new
  Portch.machine_check
  puts 'Do you want to test Games or Systems ports? (G/S)'
  resp2 = gets.chomp
  case resp2
  when 'S'
    case $nodenm
    when 'dragon'
      Portch.port_type_dragon(1)
    when 'gemini'
      Portch.port_type_gemini(1)
    when 'shuttle'
      Portch.port_type_shuttle(1)
    else
      Error_handler.new('Running the Systems Port Check', 'Error Code: 287')
    end
  when 's'
    case $nodenm
    when 'dragon'
      Portch.port_type_dragon(1)
    when 'gemini'
      Portch.port_type_gemini(1)
    when 'shuttle'
      Portch.port_type_shuttle(1)
    else
      Error_handler.new('Running the Systems Port Check', 'Error Code: 287')
    end
  when 'G'
    case $nodenm
    when 'dragon'
      Portch.port_type_dragon(2)
    when 'gemini'
      Portch.port_type_gemini(2)
    when 'shuttle'
      Portch.port_type_shuttle(2)
    else
      Error_handler.new('Running the Games Port Check', 'Error Code: 287')
    end
  when 'g'
    case $nodenm
    when 'dragon'
      Portch.port_type_dragon(2)
    when 'gemini'
      Portch.port_type_gemini(2)
    when 'shuttle'
      Portch.port_type_shuttle(2)
    else
      Error_handler.new('Running the Port Check', 'Error Code: 287')
    end
  else
    Error_handler.new('running the Port Check', 'Error Code: 287')
  end
when 'N'
  puts 'Skipping!'
when 'n'
  puts 'Skipping!'
else
  Error_handler.new('understanding your response!', 'Please contact Veth/Connor!')
end



