class UserPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    admin? || user.id == record.id
  end
end
