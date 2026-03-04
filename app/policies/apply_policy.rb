class ApplyPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    admin? || user.id == record.user_id || user.id == record.job.user_id
  end

  def create?
    user.role == "candidate"
  end

  def new?
    create?
  end

  def update?
    admin? || (user.role == "recruiter" && user.id == record.job&.user_id)
  end

  def edit?
    update?
  end

  def destroy?
    return true if admin?

    user.role == "candidate" && user.id == resource.user_id
  end
end
