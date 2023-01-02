#!/bin/ruby
# frozen_string_literal: true

require_relative './tests/Nginx-test'
require_relative './tests/Port-test'
require_relative './classes/managers/Directory-manager'
require_relative './classes/handlers/Error-handler'
require_relative './classes/system/Logman'

# Let's quickly get our good friend Logman running
Logman.new
Logman.setup_log_to_file
Logman.setup_log_to_stdout

# Now let's print a nice little greeting message
two_lines = RubyFiglet::Figlet.new("Pixelated\nNodeCheck")
two_lines.show

# sleeping on the job because RubyFiglet likes to hang after printing on slower systems
sleep(2)

# Time to ask the user if they want to test Nginx
puts 'Would you like to check Nginx for this node? (Y/N)'

# Now let's grab their response
resp = gets.chomp

# We use the ::downcase method so the logic isn't repeated over and over
case resp.downcase
when 'Y'
  puts 'Checking NGINX status'

  # The user wants to test Nginx, so let's start up a new nginx test instance. Thankfully that's all we need to test it
  Nginxcheck.new
when 'N'
  puts 'Skipping Nginx Check!'
else

  # if the program fails to parse the user input for anything,
  # instead of just crashing, let's handle the error so we can continue
  ErrorHandler.new('error', 'System encountered an error determining whether or not to run the Nginx test!')
end

# now let's see if the user wants to check the ports
puts 'Would you like to test ports for this node? (Y/N)'
resp1 = gets.chomp
case resp1.downcase
when 'Y'

  # if they do, let's init the PortCheck class
  PortCheck.new

  # Now let's ask if the user wants to test Systems or Games ports
  puts 'Do you want to test Games or Systems ports? (G/S)'
  resp2 = gets.chomp

  case resp2.downcase
  when 'S'
    case @nodenm
    when 'dragon'

      # Now let's run the Port Check on the requested port type
      PortCheck.port_type_dragon(1)
    when 'gemini'
      PortCheck.port_type_gemini(1)
    when 'shuttle'
      PortCheck.port_type_shuttle(1)
    else
      ErrorHandler.new('error', 'Ran into issue running the Systems Port Check')
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
      ErrorHandler.new('error', 'Failure running the Games Port Check')
    end
  else
    ErrorHandler.new('error', 'Failure running the Port Check!')
  end

when 'N'
  puts 'Skipping!'
else
  ErrorHandler.new('fatal', 'Critical Failure interpreting user input! Please contact Veth/Connor!')
end
