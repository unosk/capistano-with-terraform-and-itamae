require 'spec_helper'

describe 'ruby' do
  describe ppa('brightbox/ruby-ng') do
    it { should exist }
    it { should be_enabled }
  end

  describe package('ruby2.2') do
    it { should be_installed }
  end

  describe command('ruby --version') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match(/2\.2\.\d+/) }
  end
end
