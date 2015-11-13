require 'spec_helper'
describe 'bash_user_skel', :type => :define do

  let :facts do 
    {
      :os => {
        :family => "redhat"
      }
    }
  end

  context 'compiles ok' do
    let :title do
      "test"
    end
    it { should compile }
  end

end
