#!/bin/Ruby
# frozen_string_literal: true

# Class for checking what Node the system is running on
class MachineChecker
  require_relative '../../handlers/Error-handler'
  require_relative '../../system/Logman/Logman'
  attr_accessor :nodenm

  def initialize
    uuid = `cat /etc/uuid`.chomp
    check(uuid)
  end

  def check(uuid)
    case uuid
    when 'm95jnv_n5T3bmc8kmSiFSDigFTZ5UWHSkZcpWdnFdtgdkoGEvw7F7CdCK8GnrAD2'; @nodenm = 'dragon'
                                                                             puts 'Detected Dragon!'
    when 'rCGWs2lYYrEVdD6JjaXS12bMxJf_z8KefCcoIQ4wNmRPXpgOn7HcnS_i5WnYW43A'; @nodenm = 'gemini'
                                                                             puts 'Detected Gemini!'
    when 'wDdG98AvHFB7X1fPIUOlSlMQCLZxm3sG62SrQ1O6ZfeOrzcmYMJNBbU15DJM9WQ6'; @nodenm = 'shuttle'
                                                                             puts 'Detected Shuttle!'
    else
      ErrorHandler.new('fatal', 'Ran into issue Detecting Machine!')
    end
  end
end
