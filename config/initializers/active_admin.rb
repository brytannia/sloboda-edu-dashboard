ActiveAdmin.setup do |config|
  # == Site Title
  config.site_title = "Sloboda Edu Dashboard"

  # == Current User
  config.current_user_method = :current_user

  # == Logging Out
  config.logout_link_path = :destroy_user_session_path
  config.logout_link_method = :delete

  # == Batch Actions
  config.batch_actions = true

  # == Localize Date/Time Format
  config.localize_format = :long

  config.authentication_method = :authenticate_admin_user!
end
