# frozen_string_literal: true

require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/string'
require 'active_support/core_ext/module/delegation'
require 'json'
require 'time'

require 'rest-client'

require_relative 'alpaca/news/api'
require_relative 'alpaca/news/api/base'
require_relative 'alpaca/news/api/configuration'
require_relative 'alpaca/news/api/error'
require_relative 'alpaca/news/api/models/news'
require_relative 'alpaca/news/api/rest/base'
require_relative 'alpaca/news/api/rest/client'
require_relative 'alpaca/news/api/rest/collection'
require_relative 'alpaca/news/api/rest/news'
require_relative 'alpaca/news/api/historical_news'
require_relative 'alpaca/news/api/version'
