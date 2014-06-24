require 'spec_helper'


describe file('/dirt.txt') do
  it { should be_file }
  its(:content) { should match /this is the dirt.txt file/ }
end
