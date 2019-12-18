module QuickBook
  class AuthUrl
    require 'intuit-oauth'
    def initialize()
    end

    def call
        client = IntuitOAuth::Client.new(
                  'AB1vBNuWj77R3P5aYjki1lz9jeOx5ihJoGNjykcbF28Noz24hK',
                  '7FuAZi4kT55U92avHczZpTquCTnIsjod0aNIYxWy',
                  'https://d482eb3b.ngrok.io/v1/redirect_url',
                  'production'
                  )
        scopes = [
            IntuitOAuth::Scopes::ACCOUNTING
        ]

      client.code.get_auth_uri(scopes)
    end
  end
end
