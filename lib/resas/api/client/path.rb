require 'active_support'
require 'active_support/core_ext'
require 'uri'
require 'pathname'

class Resas::Api::Client::Path

  def self.get( api_version, *args )
    args = [ args ]
    args.flatten!
    options = args.extract_options!
    new( api_version, *args, options ).to_s
  end

  def initialize( api_version, *namespaces, options )
    raise TypeError unless namespaces.instance_of?( Array )
    raise TypeError unless options.instance_of?( Hash )

    @api_version = api_version
    @namespaces = namespaces.flatten.map( &:to_s ).map { | str |
      str.split( '/' ).map { | str2 | str2.camelize( :lower ) }
    }.flatten
    @options = options
  end

  def to_s
    result = '/' + dirs.join( '/' )
    _queries = queries

    if _queries.present?
      result += "?#{ _queries }"
    end

    result
  end

  private

  def dirs
    [ 'api', @api_version, @namespaces ].flatten
  end

  def queries
    _parameters = parameters
    _parameters.present? ? ::URI.encode_www_form( _parameters ) : nil
  end

  def parameters
    h = {}
    return nil if @options.blank?

    @options.each do | k, v |
      h[ k.to_s.camelize( :lower ) ] = [ v ].flatten.join( ',' )
    end

    h
  end

end
