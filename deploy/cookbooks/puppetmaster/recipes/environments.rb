node['puppetmaster']['environments'].each do |environment|
  execute "setup directories for #{environment} environment" do
    command "mkdir -p /etc/puppet/environments/#{environment}/{modules,manifests}"
    user 'root'
  end

  execute "setup conf file for #{environment} environment" do
    command "echo 'environment_timeout = 5s' > /etc/puppet/environments/#{environment}/environment.conf"
    user 'root'
  end
end
