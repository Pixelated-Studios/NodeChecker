#!/bin/ruby
# frozen_string_literal: true

require_relative './classes/Nginx-check'
require_relative './classes/Port-check'
require_relative './classes/Error-handler'
require_relative './classes/Logman'
require_relative './Gemfile'

Logman.new
Logman.setup_log_to_file
Logman.setup_log_to_stdout

two_lines = RubyFiglet::Figlet.new("Pixelated\nNodeCheck")
two_lines.show
Logman.log_to_file('info', 'Displayed Greeting')
sleep(2)

puts 'Checking NGINX status'
Nginxcheck.new
if ($nginxstatus = 0)
  puts 'Checking Ports!'
  sleep(1)
  Port_check.new
else
  puts 'Previous test failed, Skipping!'
  sleep(1)
end

puts 'Would you like to test ports for this node? (Y/N)'
resp1 = gets.chomp
case resp1.downcase
when 'Y'
  Port_check.new
  Port_check.machine_check
  puts 'Do you want to test Games or Systems ports? (G/S)'
  resp2 = gets.chomp
  case resp2.downcase
  when 'S'
    case $nodenm
    when 'dragon'
      Port_check.port_type_dragon(1)
    when 'gemini'
      Port_check.port_type_gemini(1)
    when 'shuttle'
      Port_check.port_type_shuttle(1)
    else
      Error_handler.new('Running the Systems Port Check', 'Error Code: 287')
    end
  when 'G'
    case $nodenm
    when 'dragon'
      Port_check.port_type_dragon(2)
    when 'gemini'
      Port_check.port_type_gemini(2)
    when 'shuttle'
      Port_check.port_type_shuttle(2)
    else
      Error_handler.new('Running the Games Port Check', 'Error Code: 287')
    end
  else
    Error_handler.new('running the Port Check', 'Error Code: 287')
  end
when 'N'
  puts 'Skipping!'
else
  Error_handler.new('understanding your response!', 'Please contact Veth/Connor!')
end



