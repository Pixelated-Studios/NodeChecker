#!/bin/ruby
# frozen_string_literal: true

# class for checking if nginx is alive
class Nginxcheck
  require_relative './Error-handler'
  require_relative './Logman'

  def initialize
    if system('systemctl', 'is-active', '--quiet', 'nginx')
      puts 'Nginx Running!'
    else
      Error_handler.new('fatal', 'Nginx borked!')
    end
  end
end
