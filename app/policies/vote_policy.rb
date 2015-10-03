# Checkpoint #53 - Voting
#
# Because we need to authorize an actual Vote object before it is saved to a database, the else section of the method has been expanded. Instead of a single call to create, the Vote object is first initialized with 'build', then authorized, and finally stored in a database using 'save'.
#
# We'll also need to create a 'vote_policy.rb' file in 'app/policies/'.
#
# We don't need any overrides here because ApplicationPolicy already defined everything we need: Only Bloccit users will be able to create and update their own votes.
class VotePolicy < ApplicationPolicy
    
end