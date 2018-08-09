name 'puppet'
maintainer 'James Mac William'
maintainer_email 'jimmy.macwilliam@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures puppet'
long_description 'Installs/Configures puppet'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

depends 'ruby_rbenv'
