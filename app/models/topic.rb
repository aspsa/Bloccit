# Checkpoint #40 - Topics and Posts
#
# Update 'post.rb' and 'topic.rb' to reflect the
# 'topic_id' association.
class Topic < ActiveRecord::Base
    # Checkpoint #40 - Topics and Posts
    has_many :posts
    
    # Assignment #45 - Pagination
    #
    # 'will_paginate' also allows you to set the number of items per page in the
    # model. Use the 'per_page=(num)'' method in Topic to display 50 topics per
    # page. You'll need to modify 'TopicsController' to use the model default.
    self.per_page = 100
end
