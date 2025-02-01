# frozen_string_literal: true

class SetLocaleMiddleware
  def initialize(app)
    @app = app
  end

  # BEGIN
  def call(env)
    request = Rack::Request.new(env)

    locale = get_locale_from_header(request.env["HTTP_ACCEPT_LANGUAGE"])
    
    I18n.locale = I18n.locale_available?(locale&.to_sym) ? locale : I18n.default_locale

    @app.call(env)
  end

  private

  def get_locale_from_header(header)
    header&.scan(/^[a-z]{2}/)&.first
  end
  # END
end
