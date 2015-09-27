# Checkpoint #39 - Authorization
class PostPolicy < ApplicationPolicy
    def index?
        true
    end
    
    # Checkpoint #51 - Destroy
    #
    # Moderator users should be able to delete offensive posts. To make that possible, we have to modify the policy file for posts.
    def destroy?
        user.present? && (record.user == user || user.admin? || user.moderator?)
    end
end