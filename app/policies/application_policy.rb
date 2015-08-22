class ApplicationPolicy
  # Checkpoint #39 - Authorization
  # Default policy file created with 'rails g pundit:install'
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    # false
    # Checkpoint #39 - Authorization
    #
    # The first resource action for which we want to define a rule is 'create'.
    # Our minimum requirement for creating records like posts or comments is
    # that a user exist and be logged in.
    user.present?
  end

  def new?
    create?
  end

  def update?
    # false
    # Checkpoint #39 - Authorization
    #
    # Our rule for updating records is more complex. Aa user needs to be either
    # the record's owner or the general administrator, on top of being present
    # and logged in.
    user.present? && (record.user == user || user.admin?)
  end

  def edit?
    update?
  end

  def destroy?
    # false
    # Checkpoint #39 - Authorization
    #
    # 'edit?' follows the same rule, as does 'destroy?', so we can keep
    # 'edit?' as is, and modify 'destroy?' to also delegate to 'update?'.
    update?
  end

  def scope
    # Pundit.policy_scope!(user, record.class)
    # Checkpoint #39 - Authorization
    #
    # The default statement is more involved that actually required (for this
    # checkpoint), so replace the definition with the following.
    #
    # With this replacement, scope simply returns the class of the record
    # being authorized. For example, for a post instance it will return the
    # 'Post' class.
    record.class
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
