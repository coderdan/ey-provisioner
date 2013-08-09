require 'spec_helper'

describe Ey::Provisioner::Connection do
  subject    { Ey::Provisioner::Connection.new("tokenabc") }
  let(:http) { stub('http') }
  before     { Excon.expects(:new).with(Ey::Provisioner::Connection::EY_API_CLOUD_URL).returns(http) }

  let(:headers) do
    {
      'Accept' => 'application/json',
      'X-EY-Cloud-Token' => 'tokenabc',
      'Content-type' => 'application/json'
    }
  end

  describe "http_post" do
    let(:request) { stub('request') }
    before        { request.expects(:to_hash).returns(:test => 'data') }

    it "should post via HTTP to the API" do
      http.expects(:post).with(
        :body    => JSON(:request => { :test => 'data' }),
        :headers => headers,
        :path    => "/api/v2/testpath",
        :expects => [200, 201, 202]
      )
 
      subject.http_post("testpath", request)
    end
  end
end
