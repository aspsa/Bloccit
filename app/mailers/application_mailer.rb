class ApplicationMailer < ActionMailer::Base
  # Checkpoint #55 - Favoriting
  #
  # Open app/mailers/favorite_mailer.rb and update the from address to be your email address.
  #
  # This sets the default from for all emails sent within this class.
  #
  #default from: "from@example.com"
  default from:  "123aspsa123@gmail.com"
  layout 'mailer'
  
  # Checkpoint #55 - Favoriting
  #
  # Add a new_comment method in this class. This is the method you'll call in order to send an email to someone about their favorite posts.
  #
  # We set three different headers to enable threading in different email clients.
  def new_comment(user, post, comment)
    # New Headers
    headers["Message-ID"] = "<comments/#{comment.id}@aspsa-bloccit.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@aspsa-bloccit.example>"
    headers["References"] = "<post/#{post.id}@aspsa-bloccit.example"
    
    # Checkpoint #55 - Favoriting
    #
    # You'll notice that we define three instance variables to equal local variables, but then never use them. What's going on?
    #
    # ActionMailer follows a similar pattern to Rails controllers: You can define instance variables that will be available to your "view" - the content sent in the email.
    @user = user
    @post = post
    @comment = comment
    
    # Checkpoint #55 - Favoriting
    #
    # The most important line in this method is the last. The mail method takes a hash of mail-relevant information - the subject, the to address, the from (we're using the default), and any cc or bcc information you want - and prepares the email to be sent.
    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end