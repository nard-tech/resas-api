require 'json'

class Resas::Api::Client::Response::Body

  def initialize( body )
    @body = JSON.parse( body )
  end

  def result
    Resas::Api::Client::Response::Body::Result.new( @body[ 'result' ] )
  end

  def name
    @body[ 'name' ]
  end

end
