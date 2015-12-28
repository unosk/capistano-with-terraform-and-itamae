require 'spec_helper'

describe 'app' do
  describe service('unicorn') do
    it { should be_enabled }
    it { should be_monitored_by('monit') }
  end

  describe service('sidekiq') do
    it { should be_enabled }
    it { should be_monitored_by('monit') }
  end

  describe command('logrotate -d /etc/logrotate.d/unicorn') do
    its(:exit_status) { should eq 0 }
  end

  describe command('logrotate -d /etc/logrotate.d/sidekiq') do
    its(:exit_status) { should eq 0 }
  end
end
