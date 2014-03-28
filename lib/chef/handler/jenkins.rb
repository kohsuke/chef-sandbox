require "chef/log"
# require 'pry'
require 'digest/md5'

module Jenkins
  class TrackingHandler < Chef::Handler
    def report
      # for interactive exploration
      # binding.pry

      puts "Machine name: #{run_status.node.name}"
      run_status.updated_resources.each do |res|
        # res is instance of CookbookFile
        if res.class <= Chef::Resource::File
          puts "Updated file"
          puts "  path = #{res.path}"
          puts "  action = #{res.action}"
          puts "  md5 = #{Digest::MD5.hexdigest(IO.read(res.path))}"
          # res.checksum is SHA1 sum
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
end