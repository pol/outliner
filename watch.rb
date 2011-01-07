#!/usr/bin/env ruby
# Script to watch a directory for any changes to a haml file
# and compile it.
#
# USAGE: ruby haml_watch.rb <directory_to_watch>
#
require 'rubygems'
require 'fssm'

directory = File.join(File.dirname(__FILE__), '.')
FSSM.monitor(directory, 'Outline.rb') do
  update do |base, relative|
    output = "outline.html"
    command = "ruby #{relative} > #{output} && tidy -m #{output}"
    %x{#{command}}
    puts "Regenerated #{relative} to #{output}"
  end
end

