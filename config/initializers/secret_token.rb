# Checkpoint #37 - Authentication Continued
# Bloccit::Application.config.secret_key_base = 123456678910abcdefg
Bloccit::Application.config.secret_key_base = ENV['SECRET_KEY_BASE']