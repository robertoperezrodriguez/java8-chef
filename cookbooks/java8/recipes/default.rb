file "/home/ubuntu/hello.txt" do
  content "hello world"
end

user 'roberto' do
  comment 'A random user'
  home '/home/roberto'
  shell '/bin/bash'
  password '$1$xyz$YlfeMrXIqbFiHctbX2u24.'
end

directory '/home/roberto' do
  owner 'roberto'
  group 'roberto'
  mode '0755'
  action :create
end

execute 'copy-ssh' do
  command 'cd ~roberto ; cp -r ~ubuntu/.ssh . && chmod 700 .ssh && chown -R roberto .ssh'
end

apt_repository "webupd8team" do
  uri "http://ppa.launchpad.net/webupd8team/java/ubuntu"
  components ['main']
  distribution node['lsb']['codename']
  keyserver "keyserver.ubuntu.com"
  key "EEA14886"
  deb_src true

end

# could be improved to run only on update
execute "accept-license" do
  command "echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections"
end

package "oracle-java8-installer" do
  action :install
end

package "oracle-java8-set-default" do
  action :install
end
