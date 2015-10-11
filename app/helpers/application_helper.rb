# Checkpoint #42 - Validating Posts
#
# Styling the elements on the form partial is a little tricky. If the
# form displays errors, we want a certain style, and if the form doesn't
# display errors, we want a different style. We could include conditional
# logic directly in our view -- but that would be a code smell, because
# Rails conventions strongly suggest keeping as much logic as possible out
# of the view. Views cluttered with if and else statements are clunky,
# hard to maintain, and confusing. We'll use the ApplicationHelper
# to implement a DRY solution for toggling div classes.
#
# You can write methods in the ApplicationHelper that can be used across
# your application. It's actually a Module that Rails includes with other
# classes in your app. Basically, any public method you write in
# ApplicationHelper will be available anywhere. Why is this both a
# blessing and a curse?
#
# There's something special happening to the block - notice the &? This
# turns the block into a Proc object, which we've seen before but haven't
# named. A Proc is like a block, only it can be reused like a variable.
#
# Helpers are in Ruby and often return HTML. The content_tag is one
# such method, which takes a symbol argument, a block, and an options
# hash. It then creates the symbol-specified HTML tag with the block
#contents (and, if specified, the options).
module ApplicationHelper
    def form_group_tag(errors, &block)
        if errors.any?
            content_tag :div, capture(&block), class: 'form-group has-error'
        else
            content_tag :div, capture(&block), class: 'form-group'
        end
    end
    
    # Checkpoint #43 - Post Markdown
    def markdown_to_html(markdown)
        renderer = Redcarpet::Render::HTML.new
        extensions = {fenced_code_blocks: true}
        redcarpet = Redcarpet::Markdown.new(renderer, extensions)
        
        # Checkpoint #43 - Post Markdown
        #
        # Note the call to html_safe. Rails ordinarily "escapes" strings
        # rendered to HTML, turning < to &lt; (the "HTML entity" for "less
        # than"), for example, so that it isn't confused as an opening to a tag.
        # This is great unless you want your string to be rendered as HTML, as
        # we do here. To get around this escaping, we call html_safe.
        (redcarpet.render markdown).html_safe
    end

    # Assignment #57 - Another Interlude
    #
    # Recall the state of our _voter.html.erb partial. In it, our links look like this:
    #
    # app/views/votes/_voter.html.erb
    #      <%= link_to " ",
    #        post_down_vote_path(post),
    #        class: "glyphicon glyphicon-chevron-down #{(current_user.voted(post)
    #           && current_user.voted(post).down_vote?) ? 'voted' : '' }",
    #           method: :post %>
    #
    # The ternary operator keeps things to one line, but it also makes this line extremely verbose, confusing, and prone to syntax errors. Move this logic into a helper file.
    #
    #   - Define two helper methods in ApplicationHelper: up_vote_link_classes and down_vote_link_classes.
    #
    #   - The methods should each return a string with the appropriate classes for an up or down vote link.
    #
    #   - Each method should accept a post as an argument.
    #
    #   - up_vote_link_classes and down_vote_link_classes should call up_vote? or down_vote? respectively.
    #
    #   - Use the new helper methods in the view in place of the long interpolated string.
    def up_vote_link_clasess(post)
        (current_user.voted(post) && current_user.voted(post).up_vote?) ? 'voted' : ''
    end
    
    def down_vote_link_classes(post)
        (current_user.voted(post) && current_user.voted(post).down_vote?) ? 'voted' : ''
    end
end