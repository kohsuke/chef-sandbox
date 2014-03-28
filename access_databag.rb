#!/usr/bin/env ruby
# Experiment to access databag
require 'rubygems'
require 'chef'
require 'pry'

Chef::Config.from_file("/home/kohsuke/.chef/knife.rb")
# or read config like chef-client
# Chef::Config.from_file("/etc/chef/client.rb")

begin
  Chef::DataBag.load("jenkins")
rescue Net::HTTPServerException => e
  if e.response.code=="404"
    bag = Chef::DataBag.new
    bag.name "jenkins"
    bag.save
  end
end

i = Chef::DataBagItem.new
i.data_bag("jenkins")  # set the name

i.raw_data = { "id" => 'test2', "random" => 5 }
i.save