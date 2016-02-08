Devise.setup do |config|
  # ==> Mailer Configuration
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  # ==> ORM configuration
  require 'devise/orm/active_record'

  # ==> Configuration for any authentication mechanism
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]

  # ==> Configuration for :database_authenticatable
  config.stretches = Rails.env.test? ? 1 : 10

  # ==> Configuration for :confirmable
  config.reconfirmable = true

  # ==> Configuration for :rememberable
  config.expire_all_remember_me_on_sign_out = true

  # ==> Configuration for :validatable
  config.password_length = 8..72

  # ==> Configuration for :recoverable
  config.reset_password_within = 6.hours


  config.sign_out_via = :delete
  config.secret_key = '148392097cf1a1b8e0f791dc70b3f519859bc98e94471c0d976183563eb94227dcc9ed088ad3f0e5bb7b2f392c80c0dd0fc187f2ec8ef61e2531abe84da0f07f'
end
