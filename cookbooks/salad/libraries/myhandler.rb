require "chef/log"
require 'pry'
require 'digest/md5'

class MyHandler < Chef::Handler
  def report
    # for interactive exploration
    # binding.pry

    puts "Machine name: #{run_status.node.name}"
    run_status.updated_resources.each do |res|
      # res is instance of CookbookFile
      if res.class==Chef::Resource::CookbookFile
        puts "Updated file"
        puts "  path = #{res.path}"
        puts "  action = #{res.action}"
        puts "  md5 = #{Digest::MD5.hexdigest(IO.read(res.path))}"
        # TODO: what is res.checksum?
      end

      if res.class == Chef::Resource::SaladJenkinsTracking
        # TODO is this a good way to check the class name?
        puts "Tracked"
        puts "  path = #{res.path}"
        puts "  md5 = #{res.checksum}"
      end
    end
  end
end