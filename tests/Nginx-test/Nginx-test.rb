#!/bin/ruby
# frozen_string_literal: true

# class for checking if nginx is alive
class Nginxcheck
  require_relative '../../classes/handlers/Error-handler'
  require_relative '../../classes/system/Logman'

  # in this test we only need an init method. Because we can quickly and easily test if Nginx is running with a
  # systemctl command ran through ::Kernel
  def initialize
    if system('systemctl', 'is-active', '--quiet', 'nginx')
      puts 'Nginx Running!'
    else
      ErrorHandler.new('error', 'Nginx borked!')
    end
  end
end
