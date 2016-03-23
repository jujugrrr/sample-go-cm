require 'spec_helper'

describe 'sample-go-cm::default' do
  describe command('wget -qO - "localhost:8484"') do
    its(:stdout) do
      should match(
        /Hi there, I'm served from .*!/
      )
    end
  end
  describe user('samplego') do
    it { should exist }
  end
  describe user('samplego') do
    # rubocop:disable Metrics/LineLength
    it { should have_authorized_key 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCnU95zbYW87Ohouit47nYr0qeKw9xtMRX2jkiRtBkZdLHBsc6o0FbI1vy0U4HeX8wlN5X+yLxMY2XP692Rvzcn2EfzjBZY0BcAnCp/i1cjG/KqNarQGTOV5BPHU2HgDLZq1KAee195BQTvaA1O65DgDEq3fFBoiuceEi93TIm74BPimigUmRBtDPX6cOLKBkpoJ6ARCAJBSLL4XZhFQMbYlTwGIVEHiUhJj9m+RLSXzvKBl1q0f9+zBIQqL8gwL9W8at6h8Pqxs4Hm1k/DewSQtQUmnrqF8IdJKg6oY/ScpzaGHaW6cyjufD1/thsfZEgL7tS0b369VEtnnCCf1uBN circleci@all' }
  end
  # rubocop:enable Metrics/LineLength
end
