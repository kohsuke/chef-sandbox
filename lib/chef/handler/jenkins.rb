require "chef/log"
# require 'pry'
require 'digest/md5'

module Jenkins
  class TrackingHandler < Chef::Handler
    def report
      # for interactive exploration
      # binding.pry

      report = []

      puts "Machine name: #{run_status.node.name}"
      run_status.updated_resources.each do |res|
        # res is instance of CookbookFile
        if res.class <= Chef::Resource::File
          report << {
            "path" => res.path,
            "action" => res.action,
            "md5" => Digest::MD5.hexdigest(IO.read(res.path)),
            "type" => res.class.name
          }
          # res.checksum is SHA1 sum
        end

        if res.class == Chef::Resource::SaladJenkinsTracking
          # TODO is this a good way to check the class name?
          report << {
              "path" => res.path,
              "md5" => res.checksum,
              "type" => res.class.name
          }
        end
      end

      print report.inspect
    end
  end
end