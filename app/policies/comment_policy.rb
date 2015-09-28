# Assignment #46 - Comments
#
# If you try to create a comment without first signing in, you'll encounter a no
# method 'id' for NilClass error. This error is thrown because current_user is
# nil when you're not signed in, and comment creation attempts to extract an id
# from this nil object.
#   - Create a CommentPolicy class inheriting from ApplicationPolicy.
#   - Define new and create methods for CommentPolicy. A comment should only be
#     able to be created if a user is present.
class CommentPolicy < ApplicationPolicy
    def new?
       create?
    end
    
    def create?
        user.present?
    end
    
    # Checkpoint #51 - Destroy
    #
    # Create a 'CommentPolicy' class with a 'destroy?'' action
    def destroy?
       user.present? && (record.user == user || user.admin? || user.moderator?) 
    end
end