require 'digest/md5'

def whyrun_supported?
  true   # ???
end

action :track do
  new_resource.updated_by_last_action(true)

  path = new_resource.path
  # converge_by("Track fingerprint of #{path}")
  new_resource.checksum = Digest::MD5.hexdigest(IO.read(path))
  puts "Computed checksum #@checksum"
end


# this is not getting called early enough
def load_current_resource
  @current_resource = Chef::Resource::SaladJenkinsTracking.new(@new_resource.name)

  path = @new_resource.path
  if ::File.exists? path
    digest = Digest::MD5.hexdigest(IO.read(path))
    puts "Current=#{digest}"
    @current_resource.checksum = digest
  end
end
