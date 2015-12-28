require 'spec_helper'

describe 'redis' do
  describe ppa('chris-lea/redis-server') do
    it { should exist }
    it { should be_enabled }
  end

  describe package('redis-server') do
    it { should be_installed }
  end

  describe service('redis-server') do
    it { should be_enabled }
    it { should be_running }
    it { should be_monitored_by('monit') }
  end

  describe port(6379) do
    it { should be_listening }
  end
end
