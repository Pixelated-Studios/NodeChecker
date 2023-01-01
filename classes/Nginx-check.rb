#!/bin/ruby
# frozen_string_literal: true

# class for checking if nginx is alive
class Nginxch
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
