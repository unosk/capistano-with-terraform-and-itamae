require 'spec_helper'

describe 'monit' do
  describe package('monit') do
    it { should be_installed }
  end

  describe service('monit') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(2812) do
    it { should be_listening }
  end
end
