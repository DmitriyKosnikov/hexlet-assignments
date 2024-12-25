# frozen_string_literal: true

require 'digest'

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    status, headers, prev_response = @app.call(env)

    body = prev_response.reduce('') { |acc, elem| acc + elem }

    signature = Digest::SHA2.hexdigest(body)

    body = "#{body}\n#{signature}"

    [status, headers, [body]]
    # END
  end
end
