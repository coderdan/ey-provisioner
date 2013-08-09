require 'spec_helper'

RSpec::Matchers.define :api_post do |input|
  chain :with do |body|
    @body = body
  end

  chain :to do |to|
    @to = to
  end

  chain :respond_with do |resp|
    @response = resp
  end

  match do |sub|
    if @body && @to
      Excon::Connection.any_instance.expects(:post).with(
        :body    => JSON(@body),
        :headers => {'Accept' => 'application/json', 'X-EY-Cloud-Token' => '1234', 'Content-type' => 'application/json'},
        :path    => @to,
        :expects => [200, 201, 202]
      ).returns(@response)
    else
      Excon::Connection.any_instance.expects(:post)
    end
  end
end

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

      before do
        response.stubs(:body).returns(JSON('instance' => { 'id' => 1234 }))
      end

      it "should post the data" do
        Ey::Provisioner::Request.expects(:new).returns(request)
        request.expects(:body).returns(:request => { :name => "worker", :role => "util" })

        should api_post.to(add_instance_path).with(:request => { :name => "worker", :role => "util" }).respond_with(response)
        subject.add_instance("1")
      end

      context "with options" do
        it "should post the data" do
          Ey::Provisioner::Request.expects(:new).with(:name => "Name", :role => "app").returns(request)
          request.expects(:body).returns(:request => { :name => "Name", :role => "app" })

          should api_post.to(add_instance_path).with(:request => { :name => "Name", :role => "app" }).respond_with(response)
          subject.add_instance("1", :name => "Name", :role => "app")
        end
      end

      it "should return the instance" do
        Ey::Provisioner::Request.expects(:new).returns(request)
        request.expects(:body).returns(:request => { :name => "worker", :role => "util" })

        should api_post.to(add_instance_path).with(:request => { :name => "worker", :role => "util" }).respond_with(response)

        subject.add_instance("1").should be_a(Ey::Provisioner::Instance)
      end
    end
  end
end
