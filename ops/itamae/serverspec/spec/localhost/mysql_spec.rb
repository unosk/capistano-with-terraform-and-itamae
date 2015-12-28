require 'spec_helper'

describe 'mysql' do
  describe package('mysql-server-5.6') do
    it { should be_installed }
  end

  describe service('mysql') do
    it { should be_enabled }
    it { should be_running }
    it { should be_monitored_by('monit') }
  end

  describe port(3306) do
    it { should be_listening }
  end
end
