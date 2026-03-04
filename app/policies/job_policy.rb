class JobPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    admin? || user.role == "recruiter"
  end

  def new?
    create?
  end

  def update?
    return true if admin?

    # Job model must have user_id
    user.role == "recruiter" && user.id == record.user_id
  end

  def destroy?
    update?
  end
end
