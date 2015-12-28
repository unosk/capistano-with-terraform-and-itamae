require 'spec_helper'

describe 'nginx' do
  describe ppa('nginx/stable') do
    it { should exist }
    it { should be_enabled }
  end

  describe package('nginx') do
    it { should be_installed }
  end

  describe service('nginx') do
    it { should be_enabled }
    it { should be_running }
    it { should be_monitored_by('monit') }
  end

  describe port(80) do
    it { should be_listening }
  end
end
