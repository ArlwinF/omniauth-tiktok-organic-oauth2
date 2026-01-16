# OmniAuth TikTok (Organic API) OAuth2 Strategy
Strategy to authenticate with TikTok (Organic API) via OAuth2 in OmniAuth

Sign up and create your Application at https://ads.tiktok.com/i18n/login.  Note the App ID and the App Secret.

For more details, read the docs: https://business-api.tiktok.com/portal/docs?id=1738083939371009

## Installation

Add to your `Gemfile`:

```ruby
gem 'omniauth-tiktok-organic-oauth2'
```

Then `bundle install`.

## Usage

Here's an example for adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :tiktok_organic_oauth2,
    Rails.application.credentials[:oauth][:tiktok][:client_id],
    Rails.application.credentials[:oauth][:tiktok][:client_secret],
    {
      name: 'tiktok_organic',
    }
  )
end
```

You can now access the OmniAuth TikTok OAuth2 URL: `/auth/tiktok_organic_oauth2`