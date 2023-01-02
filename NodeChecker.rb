#!/bin/ruby
# frozen_string_literal: true

require_relative './tests/Nginx-test'
require_relative './tests/Port-test'
require_relative './classes/managers/Directory-manager'
require_relative './classes/handlers/Error-handler'
require_relative './classes/system/Logman'

Logman.new
Logman.setup_log_to_file
Logman.setup_log_to_stdout

two_lines = RubyFiglet::Figlet.new("Pixelated\nNodeCheck")
two_lines.show
sleep(2)

puts 'Checking NGINX status'
Nginxcheck.new

puts 'Would you like to test ports for this node? (Y/N)'
resp1 = gets.chomp
case resp1.downcase
when 'Y'
  PortCheck.new
  puts 'Do you want to test Games or Systems ports? (G/S)'
  resp2 = gets.chomp
  case resp2.downcase
  when 'S'
    case @nodenm
    when 'dragon'
      PortCheck.port_type_dragon(1)
    when 'gemini'
      PortCheck.port_type_gemini(1)
    when 'shuttle'
      PortCheck.port_type_shuttle(1)
    else
      ErrorHandler.new('fatal', 'Ran into issue running the Systems Port Check')
    end
  when 'G'
    case @nodenm
    when 'dragon'
      PortCheck.port_type_dragon(2)
    when 'gemini'
      PortCheck.port_type_gemini(2)
    when 'shuttle'
      PortCheck.port_type_shuttle(2)
    else
      ErrorHandler.new('fatal', 'Failure running the Games Port Check')
    end
  else
    ErrorHandler.new('fatal', 'Failure running the Port Check!')
  end
when 'N'
  puts 'Skipping!'
else
  ErrorHandler.new('fatal', 'Critical Failure interpreting user input! Please contact Veth/Connor!')
end
