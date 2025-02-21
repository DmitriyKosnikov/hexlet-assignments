# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'net/http'

class Hacker
  class << self
    def hack(email, password)
      # BEGIN
      uri = URI('https://rails-collective-blog-ru.hexlet.app/users/sign_up')
      response = Net::HTTP.get_response(uri)
      
      doc = Nokogiri::HTML(response.body)
      csrf_input = doc.at('input[name="authenticity_token"]')
      csrf_token = csrf_input['value'] if csrf_input

      cookies = response['Set-Cookie']

      uri = URI('https://rails-collective-blog-ru.hexlet.app/users')
      request = Net::HTTP::Post.new(uri.path)
      request['Cookie'] = cookies
      request.set_form_data(
        'authenticity_token': csrf_token,
        'user[email]': email,
        'user[password]': password,
        'user[password_confirmation]': password
      )

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      response = http.request(request)
    end
    # END
  end
end
