require 'spec_helper'

describe Ey::Provisioner::Environment do
  before(:all)      { Excon.defaults[:mock] = true }
  let(:connection)  { Ey::Provisioner::Connection.new("123456789") }
  subject           { Ey::Provisioner::Environment.new(connection, "1") }

  describe "Add instance" do
    let(:path) { 'environments/1/add_instances' }

    context "an invalid server response" do
      before { Excon.stub({:method => :post}, {:status => 500}) }

      it "will throw an error" do
        expect { subject.add_instance }.to raise_error(Ey::Provisioner::APIError)
      end
    end

    context "valid server response" do
      let(:response) { stub('response') }
      let(:request)  { stub('request') }
      before         { response.stubs(:body).returns(JSON('instance' => { 'id' => 1234 })) }

      context "with default options" do
        before { Ey::Provisioner::Request.expects(:new).with({}).returns(request) }

        it "should post the data" do
          connection.expects(:http_post).with(path, request).returns(response)
          subject.add_instance
        end

        it "should return the instance" do
          connection.expects(:http_post).with(path, request).returns(response)
          subject.add_instance.should be_a(Ey::Provisioner::Instance)
        end
      end

      context "with custom options" do
        let(:options) { stub('options') }
        before { Ey::Provisioner::Request.expects(:new).with(options).returns(request) }

        it "should post the data" do
          connection.expects(:http_post).with(path, request).returns(response)
          subject.add_instance(options)
        end
      end
    end
  end

  describe "Remove instances" do
    let(:path) { 'environments/1/remove_instances' }

    context "an invalid server response" do
      before { Excon.stub({:method => :post}, {:status => 500}) }

      it "will throw an error" do
        expect { subject.remove_instances }.to raise_error(Ey::Provisioner::APIError)
      end
    end

    context "valid server response" do
      let(:response) { stub('response') }
      let(:request)  { stub('request') }
      before         { response.stubs(:body).returns(JSON('instance' => { 'id' => 1234 })) }

      context "with default options" do
        before { Ey::Provisioner::Request.expects(:new).with({}).returns(request) }

        it "should post the data" do
          connection.expects(:http_post).with(path, request).returns(response)
          subject.remove_instances
        end

        it "should return the instance" do
          connection.expects(:http_post).with(path, request).returns(response)
          subject.remove_instances.should be_a(Ey::Provisioner::Instance)
        end
      end

      context "with custom options" do
        let(:options) { stub('options') }
        before { Ey::Provisioner::Request.expects(:new).with(options).returns(request) }

        it "should post the data" do
          connection.expects(:http_post).with(path, request).returns(response)
          subject.remove_instances(options)
        end
      end
    end
  end
end
