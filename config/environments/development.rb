Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # facebook sign in
  FACEBOOK_SIGN_IN_APP_ID = '857627197619811'
  FACEBOOK_SIGN_IN_APP_SECRET = '700cd31dd5951451aa72ffd44e9f7ce8'

  # Linkedin Sign in
  LINKED_IN_SIGN_IN_CONSUMER_KEY = '75ih5a33gmx7fn'
  LINKED_IN_SIGN_IN_CONSUMER_SECRET = 'l6Iw5Z1v3tdL6SSl'

  # Gmail Sign in
  GMAIL_SIGN_IN_APP_ID = '901261843540-p46li4jg15ke68a5ga3d1d1k3m8c5365.apps.googleusercontent.com'
  GMAIL_SIGN_IN_APP_SECRET = 'QDXHuCQyI6Fe8yMqepXh_Thy'

end
