class Resas::Api::Client::Response::Body::Result

  def initialize( result )
    @result = result
  end

  def method_missing( method_name, *args, &block )
    if @result.respond_to?( method_name )
      @result.send( method_name, *args, &block )
    else
      super
    end
  rescue NoMethodError => e
    puts "method_name: #{ method_name }, @result.class: #{ @result.class }"
    raise e
  end

  def respond_to_missing?( symbol )
    @result.respond_to?( method_name, true )
  end

end
