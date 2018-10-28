require 'jwt'
class Auth
  ALGORITHM = 'HS256'

  class << self
    def encode(payload)
      JWT.encode(payload, auth_secret, ALGORITHM)
    end

    def decode(token)
      begin
        JWT.decode(token, auth_secret, true, { algorithm: ALGORITHM }).first
      rescue
        {}
      end
    end

    def auth_secret
      ENV["AUTH_SECRET"] || "movie_db"
    end
  end
end
