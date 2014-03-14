require "chef/log"
require 'pry'

class MyHandler < Chef::Handler
  def report
    binding.pry
    puts "Machine name: #{run_status.node.name}"
    run_status.updated_resources.each do |res|
      # res is instance of CookbookFile
      if res.class==Chef::Resource::CookbookFile
        puts "Updated file"
        puts "  path = #{res.path}"
        puts "  action = #{res.action}"
        # TODO: what is res.checksum?
      end
    end
  end
end