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
  class Scope < Scope
    def resolve
      if user.role == "admin"
        scope.all
      elsif user.role == "recruiter"
        scope.joins(:jobs).where(jobs: { user_id: user.id })
      else
        scope.where(user_id: user.id)
      end
    end
  end
end
