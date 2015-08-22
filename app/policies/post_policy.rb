# Checkpoint #39 - Authorization
class PostPolicy < ApplicationPolicy
    def index?
        true
    end
    
    # Assignment #39 - Authorization
    #
    # Define a Pundit 'Scope' sub-class in 'post_policy.rb' to display
    # different sets of posts based on the role of the user. Admins and
    # Moderators should see all posts, members should only see their own
    # posts, and guests should see no posts.
    #
    # Use the 'Scope' sub-class in 'posts_controller.rb' via the
    # 'policy_scope' method.
    #
    # Mentor Feedback:
    #   Member and guest scopes are not OK.
=begin
    class Scope < Scope
        def resolve_user_role
            if (user == 'admin')
                scope.all
            elsif (user == 'moderator')
                scope.all
            elsif (user == 'member')
                scope.where(:role => 'member')
            # Remaining user role; in this case 'guest'
            else
                # Do nothing...
            end
        end
    end
=end
    # I assume the Pundit 'scope' method validates Post policy here on the
    # basis of the user type.
    #
    # Need to check with mentor.
    class Scope < Scope
        def resolve_user_role
            if user.present?
                if (user.admin?) || (user.moderator?) # Defined in 'user.rb
                    scope.all
                else
                    scope.where(user_id: user.id)
                end
            end
        end
    end
end