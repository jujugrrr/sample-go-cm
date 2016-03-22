#
# Cookbook Name:: sample-go-cm
# Recipe:: nginx
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

chef_gem 'aws-sdk' do
  compile_time true
end
backends = get_backends('samplego')

include_recipe 'nginx'

template '/etc/nginx/sites-available/proxy' do
  source 'nginx/proxy.erb'
  variables backends: backends
  owner node['nginx']['user']
  group node['nginx']['user']
end

nginx_site 'proxy' do
  action :enable
end
