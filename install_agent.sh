which puppet && exit 0

which yum && sudo rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm && sudo yum install -y puppet-agent && exit 0

wget https://apt.puppetlabs.com/puppet5-release-trusty.deb
sudo dpkg -i puppet5-release-trusty.deb
sudo apt-get update
sudo apt-get install puppet-agent
