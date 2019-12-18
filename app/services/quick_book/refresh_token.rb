module QuickBook
  class RefreshToken
    require 'intuit-oauth'
    attr_reader :refresh_tokens
    def initialize( refresh_tokens:)
      @refresh_tokens = refresh_tokens
    end

    def call
      client = IntuitOAuth::Client.new(
                'AB1vBNuWj77R3P5aYjki1lz9jeOx5ihJoGNjykcbF28Noz24hK',
                '7FuAZi4kT55U92avHczZpTquCTnIsjod0aNIYxWy',
                'https://d482eb3b.ngrok.io/v1/redirect_url',
                'production')

      client.token.refresh_tokens(refresh_tokens)
    end
  end
end
