# Checkpoint #41 - Interlude
#
# You already installed Sendgrid to be your email platform in the Authentication
# checkpoint, but you still need to configure your Production environment to use
# Sendgrid.
#
# Because we're using environment-specific ENV variables, there's nothing to
# change here other than 'if Rails.env.development?', which would prohibit the
# rest of the file from being run in Production.
#
# Why include these if statements at all? That way, the code won't run by
# default in the test environment and any other environments (like a staging
# server) you might later choose to add.
#
# if Rails.env.development?
if Rails.env.development? || Rails.env.production?
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
        address:              'smtp.sendgrid.net',
        port:                 '587',
        authentication:       :plain,
        user_name:            ENV['SENDGRID_USERNAME'],
        password:             ENV['SENDGRID_PASSWORD'],
        domain:               'heroku.com',
        enable_starttls_auto: true
    }
end