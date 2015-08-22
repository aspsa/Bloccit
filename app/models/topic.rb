# Checkpoint #40 - Topics and Posts
#
# The first step in creating a new topic resource is to create a 'Topic' model.
# We're going to think ahead a little, and create an attribute named 'public'
# because we may want to restrict access to certain topics.
#
# This model was created by execution the following command in the IRB:
#       'rails g model topic name:string public:boolean description:text
class Topic < ActiveRecord::Base
    # Checkpoint #40 - Topics and Posts
    has_many :posts
end
