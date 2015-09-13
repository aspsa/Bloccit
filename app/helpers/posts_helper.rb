module PostsHelper
    # Assignment #43 - Post Markdown
    def markdown_to_html(markdown)
        render_as_markdown(md)
    end
    
    private
    
    def render_as_markdown(md)
        renderer = Redcarpet::Render::HTML.new
        extensions = {fenced_code_blocks: true}
        redcarpet = Redcarpet::Markdown.new(renderer, extensions)
        
        # Assigment #43 - Post Markdown
        # Create a private Post#render_as_markdown method that markdown_title
        # and markdown_body can call. This will keep the markdown_title and
        # markdown_body DRY.
        (redcarpet.render markdown).html_safe
    end
end