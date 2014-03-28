require "chef/log"
require 'digest/md5'

module Jenkins
  #noinspection RubyStringKeysInHashInspection
  class TrackingHandler < Chef::Handler
    def report
      # for interactive exploration
      #require 'pry'
      #binding.pry

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

      # add envelop to the data
      env = {
        "node" => run_status.node.name,
        "start_time" => run_status.start_time.rfc2822,
        "end_time" => run_status.end_time.rfc2822,
        "updates" => report
      }

      if !Chef::Config[:solo]
        # databag submission only works in chef-client
        submit_databag run_status,env
      end
      submit_jenkins run_status,env
    end

    # Submit the tracking report as a databag
    #
    # @param [Chef::RunStatus] run_status
    # @param [Hash] report
    def submit_databag(run_status, env)
      # TODO: too expensive to load them. all we want to do is to check if databag exists
      #begin
      #  Chef::DataBag.load("jenkins")
      #rescue Net::HTTPServerException => e
      #  if e.response.code=="404"
      #    bag = Chef::DataBag.new
      #    bag.name "jenkins"
      #    bag.save
      #  end
      #end

      i = Chef::DataBagItem.new
      i.data_bag("jenkins")  # set the name

      id = run_status.node.name + '_' + run_status.end_time.strftime("%Y%m%d-%H%M%S")

      i.raw_data = env
      i.save id
    end

    def submit_jenkins(run_status, env)
      r = Chef::REST.new('http://localhost:8080/')
      r.post("chef/report", env)
    end
  end
end