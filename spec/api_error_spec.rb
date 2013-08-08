require 'spec_helper'

describe Ey::Provisioner::APIError do
  subject { Ey::Provisioner::APIError.new(error) }

  describe "standard error" do
    let(:error)   { stub("error", :message => "message") }
    its(:message) { should == "message" }
  end

  describe "an HTTP error with a response" do
    context "with a state" do
      let(:body_hash) do
        {
          'request' => {"role"=>"util", "volume_size"=>"2000"},
          'status'  => 'rejected',
          'errors'  => errors
        }
      end

      context "with errors" do
        let(:errors)        { {"name"=>["can't be blank"]} }
        let(:response)      { stub("response", :body => JSON(body_hash)) }
        let(:error)         { stub("error", :message => "message", :response => response) }
        its(:message)       { should == "rejected: name can't be blank" }
        its(:error_message) { "name can't be blank" }
        its(:errors)        { errors }
      end

      context "with no errors" do
        let(:errors)        { nil }
        let(:response)      { stub("response", :body => JSON(body_hash)) }
        let(:error)         { stub("error", :message => "message", :response => response) }
        its(:message)       { should == "rejected: " }
        its(:error_message) { nil }
        its(:errors)        { nil }
      end
    end

    context "with a state" do
      let(:body_hash) do
        {
          'request' => {"role"=>"util", "volume_size"=>"2000"},
          'errors'  => errors
        }
      end

      context "with errors" do
        let(:errors)        { {"name"=>["can't be blank"]} }
        let(:response)      { stub("response", :body => JSON(body_hash)) }
        let(:error)         { stub("error", :message => "message", :response => response) }
        its(:message)       { should == "unknown: name can't be blank" }
        its(:error_message) { "name can't be blank" }
        its(:errors)        { errors }
      end
    end
  end
end
