require 'spec_helper'

describe 'misc' do
  describe package('wget') do
    it { should be_installed }
  end

  describe package('curl') do
    it { should be_installed }
  end

  describe package('git') do
    it { should be_installed }
  end

  describe package('logrotate') do
    it { should be_installed }
  end

  describe service('ssh') do
    it { should be_enabled }
    it { should be_running }
    it { should be_monitored_by('monit') }
  end

  describe service('cron') do
    it { should be_enabled }
    it { should be_running }
    it { should be_monitored_by('monit') }
  end
end
