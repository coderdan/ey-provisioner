require 'spec_helper'

RSpec::Matchers.define :api_post do |input|
  chain :with do |body|
    @body = body
  end

  chain :to do |to|
    @to = to
  end

  match do |sub|
    if @body && @to
      Excon::Connection.any_instance.expects(:post).with(
        :body    => JSON(@body),
        :headers => {'Accept' => 'application/json', 'X-EY-Cloud-Token' => '1234', 'Content-type' => 'application/json'},
        :path    => @to,
        :expects => [200, 201, 202]
      )
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
      before { Excon.stub({:method => :post}, {:status => 200}) }
      let(:headers) { {'Accept' => 'application/json', 'X-EY-Cloud-Token' => '1234', 'Content-type' => 'application/json'} }

      it "should post the right data" do
        should api_post.with({ :request => { :role => 'util' }}).to(add_instance_path) 
        subject.add_instance("1")
      end

      context "with a name provided" do
        it "should set the instance name" do
          should api_post.with({ :request => { :role => 'util', :name => 'worker' }}).to(add_instance_path) 
          subject.add_instance("1", :name => "worker")
        end
      end

      # TODO: Maybe use the presenter patter
      # Create a Request object that has a validator and build the api post params with that
      context "with role specified" do
        it "should set the instance name" do
          should api_post.with({ :request => { :role => 'app' }}).to(add_instance_path) 
          subject.add_instance("1", :role => 'app')
        end
      end

      it "should return the instance"
    end
  end
end
