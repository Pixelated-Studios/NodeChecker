#!/bin/ruby
# frozen_string_literal: true

# class for checking if nginx is alive
class Nginxcheck
  require_relative './Error-handler'
  require_relative './Directory-manager'
  require_relative './Logman'

  def initialize
    if system('systemctl', 'is-active', '--quiet', 'nginx')
      puts 'Nginx Running!'
      $nginxstatus = 0
    else
      puts 'Nginx borked!'
      $nginxstatus = 1
    end
  end
end
