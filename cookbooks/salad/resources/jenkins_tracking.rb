actions :track
default_action :track

attribute :path, :kind_of => String, :name_attribute => true

# record the calculated checksum
attr_accessor :checksum