require "chef/log"
require 'pry'
require 'digest/md5'

class MyHandler < Chef::Handler
  def report
    # for interactive exploration
    binding.pry

    # node['jenkins_tracking'] = ['md5_1','md5_2']
    # TODO: look at databags
    # databag is global
    # see http://docs.opscode.com/essentials_data_bags.html
    # see https://github.com/opscode/chef/blob/master/lib/chef/data_bag_item.rb
    # see https://github.com/opscode/chef/blob/master/lib/chef/dsl/data_query.rb#L56-L64

    puts "Machine name: #{run_status.node.name}"
    run_status.updated_resources.each do |res|
      # res is instance of CookbookFile
      if res.class==Chef::Resource::CookbookFile
        # SUGGESTION: look anything that extends File instead
        puts "Updated file"
        puts "  path = #{res.path}"
        puts "  action = #{res.action}"
        puts "  md5 = #{Digest::MD5.hexdigest(IO.read(res.path))}"
        puts "  checksum=#{res.checksum}" # this is sha256
      end

      # TODO: monitor 'package' resource

      if res.class == Chef::Resource::SaladJenkinsTracking
        # TODO is this a good way to check the class name?
        #   -> SUGGESTION: switch to HWRP
        puts "Tracked"
        puts "  path = #{res.path}"
        puts "  md5 = #{res.checksum}"
      end
    end
  end
end