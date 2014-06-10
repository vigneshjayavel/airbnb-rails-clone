# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_airbnb_clone_session',
  :secret      => '8bf7ee4fa785aa0c1de277e1448a63a66009ef3387878eabfaefb54e423207f5459d9156dd7ef0964eb0a8ce5726250012032662dee30999b129b93eef535656'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
