require 'spec_helper'
describe 'bash_user_skel' do

  context 'with defaults for all parameters' do
    it { should contain_class('bash_user_skel') }
  end
end
