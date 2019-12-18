module QuickBook
  class AuthToken
    require 'intuit-oauth'
    attr_reader :code
    def initialize(code:)
      @code = code
    end

    def call
      client = IntuitOAuth::Client.new(
                 'AB1vBNuWj77R3P5aYjki1lz9jeOx5ihJoGNjykcbF28Noz24hK',
                 '7FuAZi4kT55U92avHczZpTquCTnIsjod0aNIYxWy',
                 'https://d482eb3b.ngrok.io/v1/redirect_url',
                 'production')
      client.token.get_bearer_token(code)
    end
  end
end
