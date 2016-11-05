class Resas::Api::Client::Response

  def initialize( result )
    @result = result
  end

  def body
    Resas::Api::Client::Response::Body.new( @result.body )
  end

  def result
    body.result
  end

end
