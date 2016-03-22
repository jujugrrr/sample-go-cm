require 'spec_helper'

describe 'sample-go-cm::nginx' do
  describe command('nginx -t') do
    its(:exit_status) { should eq 0 }
  end
end
