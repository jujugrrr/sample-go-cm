require 'spec_helper'

describe 'sample-go-cm::default' do
  describe command('wget -qO - "localhost:8484"') do
    its(:stdout) do
      should match(
        /Hi there, I'm served from .*!/
      )
    end
  end
end
