require 'oauth2'
require 'omniauth/strategies/oauth2'

OAuth2::Response.register_parser(:tiktok_organic, []) do |body|
  JSON.parse(body).fetch('data') rescue body
end

module OmniAuth
  module Strategies
    class TiktokOrganicOauth2 < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = [
        'user.info.basic',
        'user.info.username',
        'user.info.stats',
        'user.info.profile',
        'user.account.type',
        'user.insights',
        'video.list',
        'video.insights',
        'comment.list',
        'comment.list.manage',
        'video.publish',
        'video.upload',
        'biz.spark.auth',
        'discovery.search.words'
      ].freeze
      USER_INFO_URL = 'https://open.tiktokapis.com/v2/user/info/'.freeze

      option :name, 'tiktok_organic_oauth2'
      option :client_options, {
        site: 'https://www.tiktok.com/',
        authorize_url: 'https://www.tiktok.com/v2/auth/authorize/',
        token_url: 'https://business-api.tiktok.com/open_api/v1.3/tt_user/oauth2/token/'
      }

      option :pkce, true

      uid { access_token.params['open_id'] }

      info do
        {
          id: raw_info['user']['open_id'],
          username: raw_info['user']['username'],
          name: raw_info['user']['display_name']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def authorize_params
        super.tap do |params|
          params[:client_key] = options.client_id
          params[:scope] ||= DEFAULT_SCOPE.join(',')
          params[:response_type] = 'code'
        end
      end

      def token_params
        options.token_params.merge(
          client_id: options.client_id,
          client_secret: options.client_secret,
          grant_type: 'authorization_code',
          auth_code: request.params['code'],
          redirect_uri: callback_url,
          parse: :tiktok_organic
        )
      end

      def callback_url
        super.split('?').first
      end

      def raw_info
        @raw_info ||= access_token.get(
          "#{USER_INFO_URL}?fields=open_id,union_id,avatar_url,display_name,username",
          parse: :tiktok
        ).parsed
      end

      def build_access_token
        client.auth_code.get_token(
          request.params['code'],
          {
            headers: {
              'Content-Type' => 'application/json'
            }
          }.merge(token_params.to_hash(symbolize_keys: true)),
          deep_symbolize(options.auth_token_params)
        )
      end
    end
  end
end
