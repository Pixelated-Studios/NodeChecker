#!/bin/ruby
# frozen_string_literal: true

# class for checking if nginx is alive
class Nginxcheck
  require_relative '../../classes/handlers/Error-handler'
  require_relative '../../classes/system/Logman'

  def initialize
    if system('systemctl', 'is-active', '--quiet', 'nginx')
      puts 'Nginx Running!'
    else
      ErrorHandler.new('fatal', 'Nginx borked!')
    end
  end
end
