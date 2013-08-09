require 'spec_helper'

describe Ey::Provisioner::Environment do
  before(:all) { Excon.defaults[:mock] = true }
  let(:token)  { "1234" }
  subject      { Ey::Provisioner::Environment.new(token) }

  describe "Add instance" do
    let(:add_instance_path) { '/api/v2/environments/1/add_instances' }

    context "an invalid server response" do
      before { Excon.stub({:method => :post}, {:status => 500}) }

      it "will throw an error" do
        expect { subject.add_instance("1") }.to raise_error(Ey::Provisioner::APIError)
      end
    end

    context "valid server response" do
      let(:response) { stub('response') }
      let(:request)  { stub("request") }
      let(:options)  { {} }

      before do
        response.stubs(:body).returns(JSON('instance' => { 'id' => 1234 }))
        Ey::Provisioner::Request.expects(:new).with(options).returns(request)
      end

      it "should post the data" do
        request.expects(:body).returns(:request => { :name => "worker", :role => "util" })
        should api_post.to(add_instance_path).with(
          :request => { :name => "worker", :role => "util" }
        ).respond_with(response)
        subject.add_instance("1")
      end

      it "should return the instance" do
        request.expects(:body).returns(:request => options)
        should api_post.to(add_instance_path).with(:request => options).respond_with(response)
        subject.add_instance("1").should be_a(Ey::Provisioner::Instance)
      end

      context "with options" do
        let(:options) { { :name => "Name", :role => "app" } }
        it "should post the data" do
          request.expects(:body).returns(:request => options)
          should api_post.to(add_instance_path).with(:request => options).respond_with(response)
          subject.add_instance("1", options)
        end
      end
    end
  end
end
