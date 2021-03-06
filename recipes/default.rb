#
# Cookbook Name:: sample-go-cm
# Recipe:: default
#
# Copyright 2016 The Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe 'golang'

# Deploy account and CI ssh key
user_account 'samplego' do
  comment   'User to run samplego'
  ssh_keys  [node['sample-go-cm']['ci-key']]
  home      '/opt/sample-go'
end
sudo 'samplego' do
  user      'samplego'
  runas     'root'
  nopasswd true
  commands ['/usr/local/bin/supervisorctl restart sample-go']
end

# Get the artifact
remote_file '/opt/sample-go/sample-go' do
  source node['sample-go-cm']['artifact_url']
  mode '0755'
  owner 'samplego'
  notifies :restart, 'supervisor_service[sample-go]', :delayed
end

# Set up the service
include_recipe 'supervisor'
supervisor_service 'sample-go' do
  command '/opt/sample-go/sample-go'
  action :enable
  user 'samplego'
end
