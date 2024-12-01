# frozen_string_literal: true

# BEGIN
require 'forwardable'
require 'uri'

class Url
  include Comparable
  extend Forwardable

  attr_accessor :uri
  attr_reader :address
  def_delegators :@uri, :host, :scheme, :port
  
  def initialize(link)
    @uri = URI(link)
    @address = link
    @params = get_params
  end

def ==(other)
  self.host == other.host && self.scheme == other.scheme && self.port == other.port && self.query_params == other.query_params
end

  def query_params
    @params
  end

  def query_param(key, value = nil)
    @params.key?(key) ? @params[key] : value
  end

  private
  def get_params
    if @uri.query.nil?
      {}
    else 
      pairs = @uri.query.split('&').map do |pair|
        pair.split('=')
      end
  
      pairs.to_h
      Hash[pairs.map{ |key, val| [key.to_sym, val] }]
    end
  end

end
# END
