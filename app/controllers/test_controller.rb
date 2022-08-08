require 'http'

class TestController < ApplicationController

    CLIENT_ID = '<change-me>'
    CLIENT_SECRET = '<change-me>'
    REDIRECT_URI = 'http://localhost:3000/oauth/callback' # URL to reflect your server machine and port
    OAUTH_URL = "https://dryad-stg.cdlib.org/oauth/authorize?" \
        "client_id=#{ERB::Util.url_encode(CLIENT_ID)}" \
        "&redirect_uri=#{ERB::Util.url_encode(REDIRECT_URI)}" \
        "&response_type=code&scope=all"

    def index

    end

    def callback
      resp = HTTP.post('https://dryad-stg.cdlib.org/oauth/token',
                json: { client_id: CLIENT_ID,
                    client_secret: CLIENT_SECRET,
                    grant_type: 'authorization_code',
                    code: params[:code],
                    redirect_uri: REDIRECT_URI})
      
      token = resp.parse['access_token']

      resp = HTTP.headers('Authorization': "Bearer #{token}").get('https://dryad-stg.cdlib.org/api/v2/test')

      hash = resp.parse
      @welcome_message = hash['message']
      @user_id = hash['user_id']
    end
end
