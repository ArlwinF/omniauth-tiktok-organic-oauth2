# frozen_string_literal: true

require_relative 'lib/omniauth-tiktok-organic-oauth2/version'

Gem::Specification.new do |gem|
  gem.name          = 'omniauth-tiktok-organic-oauth2'
  gem.version       = OmniAuthTiktokOrganicOauth2::VERSION
  gem.authors       = ['arlwin.fajardo']
  gem.summary       = 'Organic Tiktok OAuth2 Strategy for OmniAuth'
  gem.homepage      = 'https://github.com/ArlwinF/omniauth-tiktok'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split("\n")
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'oauth2', '>= 2.0.7'
  gem.add_runtime_dependency 'omniauth-oauth2', '~> 1.8'
end
