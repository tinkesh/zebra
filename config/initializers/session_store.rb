# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_aaastriping.ca_session',
  :secret      => '493cc5615dd24aba922ae9a65282cd6986ab2c15c3b0d54cd048217adeede10c76fb41d33d827d48ac5e97c91b3818487bc51a88e875a5b0f5861f72c46a8556'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
