# this is myserver_control.rb

require 'rubygems'        # if you use RubyGems
require 'daemons'

ENV['DOWNLOADER_DIR'] = Dir.pwd
Daemons.run('start.rb', {
})
