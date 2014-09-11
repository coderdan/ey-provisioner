require 'spec_helper'

describe Ey::Provisioner::Request do
  it { should validate_presence_of(:role) }

  it { should     allow_value('app').for(:role) }
  it { should     allow_value('util').for(:role) }
  it { should_not allow_value('db').for(:role) }

  Ey::Provisioner::Instance::TYPES.each do |instance_type|
    it { should allow_value(instance_type).for(:instance_size) }
  end
  it { should allow_value(:medium_ram).for(:instance_size) }
  it { should_not allow_value('another').for(:instance_size) }
  it { should     allow_value(nil).for(:instance_size) }

  describe "initialize" do
    context "all available attrs" do
      let(:request) { Ey::Provisioner::Request.new(:name => "My Name", :role => "app") }
      subject       { request }
      its(:name)    { should == "My Name" }
      its(:role)    { should == "app" }
    end

    context "an unknown attr" do
      it "should throw an error" do
        expect { Ey::Provisioner::Request.new(:foo => "bar") }.to raise_error
      end
    end

    describe "defaults" do
      let(:request) { Ey::Provisioner::Request.new }
      subject       { request }
      its(:role)    { should == "util" }
    end
  end

  describe "to_hash" do
    subject { request.to_hash }

    context "with valid data" do
      context "with only defaults" do
        let(:request) { Ey::Provisioner::Request.new }
        it            { should == { :role => 'util' } }
      end

      context "with a role" do
        let(:request) { Ey::Provisioner::Request.new(:role => 'app') }
        it            { should == { :role => 'app' } }
      end

      context "with a name provided" do
        let(:request) { Ey::Provisioner::Request.new(:name => "My Name") }
        it            { should == { :name => "My Name", :role => 'util' } }
      end

      context "with an instance size" do
        let(:request) { Ey::Provisioner::Request.new(:instance_size => "small") }
        it            { should == { :instance_size => "small", :role => 'util' } }
      end

      context "with a volume_size" do
        let(:request) { Ey::Provisioner::Request.new(:volume_size => 100) }
        it            { should == { :volume_size => "100", :role => 'util' } }
      end

      context "with a snapshot_id" do
        let(:request) { Ey::Provisioner::Request.new(:snapshot_id => "snap-99999999") }
        it            { should == { :snapshot_id => "snap-99999999", :role => 'util' } }
      end

      context "with a availability_zone" do
        let(:request) { Ey::Provisioner::Request.new(:availability_zone => "us-east-1a") }
        it            { should == { :availability_zone => "us-east-1a", :role => 'util' } }
      end
    end
  end

  context "with invalid data" do
    let(:request) { Ey::Provisioner::Request.new(:role => "invalid role") }

    it "should raise an error" do
      expect { request.to_hash }.to raise_error(Ey::Provisioner::InvalidRequest, "Invalid Request: Role is not included in the list")
    end
  end
end
