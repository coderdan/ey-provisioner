require 'spec_helper'

describe Ey::Provisioner::Instance do
  describe "initialize" do
    let(:instance_attrs) do
      {
        "amazon_id"        => "1234",
        "bootstrapped_at"  => "2013-01-01 12:00",
        "chef_status"      => [{"message"=>"Processing memcached", "timestamp"=>"2013-08-09T01:25:25+00:00"}],
        "id"               => 260323,
        "name"             => "dantest",
        "private_hostname" => "privatehostname",
        "public_hostname"  => "publichostname",
        "role"             => "util",
        "status"           => "starting"
      }
    end

    subject { Ey::Provisioner::Instance.new(instance_attrs) }
    its(:amazon_id)         { should == "1234" }
    its(:id)                { should == 260323 }
    its(:bootstrapped_at)   { should == "2013-01-01 12:00" }
    its(:chef_status)       { [{"message"=>"Processing memcached", "timestamp"=>"2013-08-09T01:25:25+00:00"}] }
    its(:name)              { should == 'dantest' }
    its(:private_hostname)  { should == 'privatehostname' }
    its(:public_hostname)   { should == 'publichostname' }
    its(:role)              { should == 'util' }
    its(:status)            { should == 'starting' }
  end
end
