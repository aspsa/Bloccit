# Checkpoint #39 - Authorization
class PostPolicy < ApplicationPolicy
    def index?
        true
    end
    
    # Assignment #39 - Authorization
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
end