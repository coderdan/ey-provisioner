
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
