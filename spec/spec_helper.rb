# -*- encoding : utf-8 -*-
require 'rubygems'

require 'coveralls'
Coveralls.wear!

require 'nokogiri'

class Rails
  def self.env
    "test"
  end
end
require 'knowledge-space-net-lib'
