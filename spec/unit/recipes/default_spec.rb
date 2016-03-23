#
# Cookbook Name:: sample-go-cm
# Spec:: default
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

require 'spec_helper'

describe 'sample-go-cm::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    before do
      stub_command('/usr/local/go/bin/go version | grep "go1.5 "').and_return(true)
    end

    it 'creates the samplego user' do
      expect(chef_run).to create_user_account('samplego')
    end

    it 'configures golang' do
      expect(chef_run).to include_recipe('golang')
    end
    it 'get the sample-go artifact' do
      expect(chef_run).to create_remote_file('/opt/sample-go/sample-go').with(mode: '0755', owner: 'samplego')
    end
    it 'configures supervisord to run sample-go' do
      expect(chef_run).to include_recipe('supervisor')
      expect(chef_run).to enable_supervisor_service('sample-go')
    end

    it 'restart the app on deploy' do
      expect(chef_run.remote_file('/opt/sample-go/sample-go')).to notify('supervisor_service[sample-go]').to(:restart).delayed
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
