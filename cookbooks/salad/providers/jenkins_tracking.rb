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